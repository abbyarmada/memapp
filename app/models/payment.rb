class Payment < ActiveRecord::Base
  belongs_to :member
  belongs_to :privilege
  belongs_to :paymenttype
  belongs_to :payment_method
  belongs_to :person
  validates_presence_of :amount,:privilege_id,:payment_method_id,:paymenttype_id,:member_id
  validates_presence_of :date_lodged, :allow_nil => false
  validates :amount, numericality: true


  #validates_associated :member

  validate :payment_type_unique_for_year ,:unless => Proc.new {|payment| payment.date_lodged.nil? } ,:if => :renewal_payment?
  validate :payment_final_and_first  , :unless => Proc.new {|payment| payment.date_lodged.nil?   } , :if => :final_payment?
  validate :check_unknown_payment_method

  attr_accessible :privilege_id , :amount, :date_lodged, :pay_type, :comment, :paymenttype_id, :member_id,:payment_method_id

  #scope :previous_renewals, -> { where([' (id <> ? or id <> 0 ) AND member_id = ?  AND date_lodged >= ? and paymenttype_id in (1,4)' , self.id, self.member_id, self.date_lodged.beginning_of_year  ] )  }
  
  scope :renewal, -> { where('paymenttype_id in (1,4 ) ')   }
  scope :current_year, -> {  where('date_lodged >= ? ', Time.now.beginning_of_year)  }
  #scope :year, -> date_lodged {  where('date_lodged >= ? ', date_lodged )  }
  scope :member, -> { where('member_id = ?', member_id )}
  scope :first_payment, ->  date_lodged { where('paymenttype_id = ? and date_lodged >= ? ' ,'4',date_lodged.beginning_of_year )   }
  scope :by_year, -> date_lodged { where(date_lodged: date_lodged.beginning_of_year..date_lodged )}
  scope :by_date_range, -> start_date,end_date { where(date_lodged: start_date..end_date )}
  scope :membership_renewal_payments, -> {where('paymenttype_id in (1,4) ')}
  scope :all_membership_payments, -> {where('paymenttype_id in (1,4,5) ')}
  scope :real_membership_renewals, -> {where('member_class not in (?,?,?,?)','X','Y','E','T')  }
  scope :year_total , -> start_date, end_date {
    all_membership_payments.
      joins(:privilege,:paymenttype).
      by_date_range(start_date,end_date)
    }
  scope :members_year_total , -> start_date, end_date {
    membership_renewal_payments.
      joins(:privilege,:paymenttype).
      by_date_range(start_date,end_date)
    }

  scope :yttypes , -> start_date, end_date {
    Payment.
      year_total(start_date,end_date).
     # select(year(date_lodged))
    select( "extract(year from date_lodged) as year, member_class, COUNT(*) as tot,SUM(amount) as money, privileges.name" ).
      group('privileges.member_class, privileges.name, year' )
    }
    
  scope :rttypes, -> start_date, end_date {
  Payment.
      members_year_total(start_date, end_date).
      select( "extract(year from date_lodged) ,member_class, COUNT(*) as paytot,COUNT(*) as paytot ,SUM(amount) as paysmoney, privileges.name" ).
      group('privileges.member_class, privileges.name, year' )
    }



  
  def main_member
    member.main_member
  end
  def renewal_payment?
     paymenttype_id  == 1 or paymenttype_id == 4
  end

  def check_unknown_payment_method
    if self.pay_type == '??'
      errors.add( :pay_type, 'Please select the correct payment method for this payment')
    end
  end

  def final_payment?
    paymenttype_id == 5
  end

  def payment_type_unique_for_year
  #Payment types 1 and 4 must not be duplicated in one year, this will cause problems with counts.
  #if self.paymenttype_id == 1 or self.paymenttype_id == 4
    if renewal_payment? & !final_payment?
      if num_duplicates > 0
        errors.add( :paymenttype_id, 'Please check the Subscription type, you cannot have two Subscription payments in one year')
      end
    end
  end

  def num_duplicates
    num_duplicates = renewals.by_year(date_lodged).count
  end

  def renewals
    if id == nil
       self.class.where('member_id = ? ',member_id).renewal
    else
      self.class.where('id <> ?  and member_id = ? ', id, member_id).renewal
    end
  end

  def payment_final_and_first
  #Must have a first payment in order to have a final payment. 
    if first_payments.count == 0
      errors.add( :paymenttype_id, "Must have a First payment to have a Final payment" )
    end
  end

  def first_payments
    Payment.first_payment(date_lodged).where('member_id = ? ',member_id)
  end

  def self.types

  {'CS' => 'Cash', 'CH' => 'Cheque', 'CC'=>'Credit Card','VC'=>'Visa','MC'=>'Mastercard','AC'=>'Amex','LA'=>'Laser', '??'=>'Unknown','NP'=>'Not Paid' }

  end

 def self.cardname(pay_type)
   cardname = types[pay_type]
 end

  def self.countpays_for_year(date)
    Payment.by_year(date).membership_renewal_payments.real_membership_renewals.joins(:privilege).group('name, member_class').order('member_class ASC').count
  end

  def self.g_chart_mems(endmonth,endday)
  #require 'google_chart'

 endmonth =   Time.now.month.to_s if endmonth.blank?
 endday =     Time.now.day.to_s if endday.blank?

    years = 5
    @types = []
      years.times do |y|
      yr_start = (Time.now.year - y).to_s + "-01-01"
        yr_end = ((Time.now.year - y).to_s + "." + endmonth + "." + endday).to_date
        @types[y] = countpays_for_year(yr_end)
    end
    classes = []
    years.times do |t|
       classes = (@types[t].keys | classes).sort
    end
    # puts "Classes:"
    #puts classes
    keys = Hash[*classes.collect {|v| [classes.index(v) ,v.to_s] }.flatten.uniq ].sort
    #puts "KEYS:"
    #puts keys
    color_code = ['0000ff','ff0000','008000','FFd700','FFa500']
    yr_end = ((Time.now.year).to_s + "." + endmonth + "." + endday).to_date
    chart = GoogleChart::LineChart.new("600x200", "Membership Trends, Year To " + yr_end.strftime('%B %d') , false)
    years.times do |x|
      chart.shape_marker :circle, :color => color_code[x], :data_set_index => x, :data_point_index => -1, :pixel_size => 10
      chart.data((Time.now.year - x), keys.collect {|k,v| @types[x][v].nil? ? 0 : @types[x][v] }, color_code[x] )
    end
  lab2 = []
    x = 0
    classes.each do |v|
       lab2 << [v]
    end
    labels = Hash[*lab2.collect {|v| [lab2,v.to_s] }.flatten]
  chart.axis :y, :range => [0,100], :font_size => 10, :alignment => :center
  chart.axis :x, :labels =>lab2, :font_size => 10, :alignment => :center
  chart.show_legend = true
  @line_graph = chart.to_url

end

def year
  self.date_lodged.strftime('%Y')
end

  def self.g_chart_mems2(endmonth,endday)
  #require 'google_chart'

 endmonth =   Time.now.month.to_s if endmonth.blank?
 endday =     Time.now.day.to_s if endday.blank?

    years = 5
    @types = []
      years.times do |y|
      yr_start = (Time.now.year - y).to_s + "-01-01"
        yr_end = ((Time.now.year - y).to_s + "." + endmonth + "." + endday).to_date
        @types[y] = countpays_for_year(yr_end)
    end
    classes = []
    years.times do |t|
       classes = (@types[t].keys | classes).sort
    end
    keys = Hash[*classes.collect {|v| [classes.index(v) ,v.to_s] }.flatten.uniq ].sort
    puts keys
    color_code = ['0000ff','ff0000','008000','FFd700','FFa500']
    yr_end = ((Time.now.year).to_s + "." + endmonth + "." + endday).to_date
    chart = GoogleChart::LineChart.new("600x200", "Membership Trends, Year To " + yr_end.strftime('%B %d') , false)
    years.times do |x|
      chart.shape_marker :circle, :color => color_code[x], :data_set_index => x, :data_point_index => -1, :pixel_size => 10
      chart.data((Time.now.year - x), keys.collect {|k,v| @types[x][v].nil? ? 0 : @types[x][v] }, color_code[x] )
    end
  lab2 = []
    x = 0
    classes.each do |v|
       lab2 << [v]
    end
    labels = Hash[*lab2.collect {|v| [lab2,v.to_s] }.flatten]
  chart.axis :y, :range => [0,100], :font_size => 10, :alignment => :center
  chart.axis :x, :labels =>lab2, :font_size => 10, :alignment => :center
  chart.show_legend = true
  @line_graph = chart.to_url

  end



  def check_renewal_date
    if (date_lodged.year == Time.now.year)  &&  renewal_payment?
      self.member.renew_date = date_lodged
      self.member.status = 'Active'
      self.member.save
    end
  end

  def renewal_payment?
    paymenttype_id  == 1 or paymenttype_id == 4
  end

  def changed_privilege?
    self.member.privilege_id != privilege_id
  end
  def update_member_privilege
    self.member.privilege_id = privilege_id
    self.member.save
  end
  def prior_renewal_payment
    renewal_paymenttypes = [1,4]
    Payment.where(:paymenttype_id => renewal_paymenttypes,:member_id => member_id).where('id != ?',id).order(:date_lodged).last
  end

  def delete_checks
    msg = ''
      if renewal_payment?
        if prior_renewal_payment
          self.member.renew_date = prior_renewal_payment.date_lodged
          msg = 'Payment Deleted - Resetting Membership Renewal Date to last Renewal Date'
          self.member.save
          if prior_renewal_payment.privilege_id != self.member.privilege_id
            self.member.privilege_id =  self.prior_renewal_payment.privilege_id
            msg = 'Payment Deleted - Resetting Membership Renewal Date and Membership Class'
            self.member.save
          end
        end
      end
    return msg
  end

#####
end
