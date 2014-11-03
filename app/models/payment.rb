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

  validate :payment_type_unique_for_year, :unless => Proc.new {|payment| payment.date_lodged.nil? }
  validate :payment_final_and_first  , :unless => Proc.new {|payment| payment.date_lodged.nil?   } , :if => :final_payment?
  validate :check_unknown_payment_method

  attr_accessible :privilege_id , :amount, :date_lodged, :pay_type, :comment, :paymenttype_id, :member_id,:payment_method_id

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
  if self.paymenttype_id == 1 or self.paymenttype_id == 4
    if self.id == nil
     num_duplicates = self.class.count(:conditions => ["(id <> ? or id <> 0 ) AND member_id = ?  AND date_lodged >= ? and paymenttype_id in (1,4)", self.id, self.member_id, self.date_lodged.beginning_of_year ])
   else
     num_duplicates = self.class.count(:conditions => ["id <> ? and  member_id = ?  AND date_lodged >= ? and paymenttype_id in (1,4)", self.id, self.member_id, self.date_lodged.beginning_of_year ])
   end
    if num_duplicates > 0
      errors.add( :paymenttype_id, 'Please check the Subscription type, you cannot have two Subscription payments in one year')
    end
  end
end

def payment_final_and_first
  #Must have a first payment in order to have a final payment. 
  count_of_first_payments = self.class.count(:conditions => ["member_id = ?  AND date_lodged >= ? and paymenttype_id = 4 ", self.member_id, self.date_lodged.beginning_of_year ])
  if count_of_first_payments == 0
    errors.add( :paymenttype_id, "Must have a First payment to have a Final payment" )
  end
end


  def self.types

  {'CS' => 'Cash', 'CH' => 'Cheque', 'CC'=>'Credit Card','VC'=>'Visa','MC'=>'Mastercard','AC'=>'Amex','LA'=>'Laser', '??'=>'Unknown','NP'=>'Not Paid' }

  end

 def self.cardname(pay_type)
   cardname = types[pay_type]
 end



def self.g_chart_mems(endmonth,endday)
#require 'google_chart'

 endmonth =   Time.now.month.to_s if endmonth.blank?
 endday =     Time.now.day.to_s if endday.blank?

    years = 5
    @types = []
      years.times do |y|
      yr_start = (Time.now.year - y).to_s + "-01-01"
      yr_end = (Time.now.year - y).to_s + "." + endmonth + "." + endday
      @types[y] = Payment.count  :all,
                             :joins => "inner join privileges ON privileges.id = payments.privilege_id",
                            :conditions => "date_lodged >= '#{yr_start}' AND date_lodged <= '#{yr_end}' and member_class not in ('X','Y','E','T' ) and payments.paymenttype_id in ('1','4') ",
        :group => 'name, member_class' ,:order => 'member_class ASC '
    end
    classes = []
    years.times do |t|
       classes = (@types[t].keys | classes).sort
    end
    keys = Hash[*classes.collect {|v| [classes.index(v) ,v.to_s] }.flatten.uniq ].sort
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
  puts chart.to_url
  @line_graph = chart.to_url

end

def year
  self.date_lodged.strftime('%Y')
end



end
