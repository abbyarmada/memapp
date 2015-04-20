class PaymentsController < ApplicationController
  before_action :set_model, only: [:show, :edit, :update, :destroy]
  respond_to :html
  require 'csv'

  def edit

  end
  def show

  end

  def update
    @payment.update(payment_params)
    respond_with(@payment) do |format|
      if @payment.save
        @payment.check_renewal_date
        format.html { redirect_to person_path(@payment.main_member) }
        if @payment.changed_privilege?
          @payment.update_member_privilege
          flash[:notice] = 'Payment Successfully Updated, Membership Class Updated.'
        else
          flash[:notice] = 'Payment Successfully Updated'
        end
      else
        format.html { render :action => "edit" }
      end
    end
  end


  def new
    @payment = Payment.new
    @payment.member_id  = (params[:member_id])
    @payment.privilege_id = @payment.member.privilege.id
    #default to Subscription renewal
    @payment.paymenttype_id = 1
    @payment.date_lodged = Time.now.to_date
  end
  def create
    @payment = Payment.new(payment_params)
    respond_with(@payment, :location => person_path(@payment.main_member) + '#tabs-1') do |format|
      if @payment.save
        @payment.check_renewal_date
        if @payment.changed_privilege?
          @payment.update_member_privilege
          flash[:notice] = 'Payment Successfully Processed -  Membership Class Updated'
        else
           flash[:notice] = 'Payment Successfully Processed'
        end
      else
        format.html { render :action => "new" }
      end
     end
  end



  def destroy

    respond_to do |format|
      if  @payment.destroy
        #set the default flash notice
        flash[:notice] = 'Payment was successfully deleted.'
        flash[:notice] =  @payment.delete_checks unless  @payment.delete_checks.blank?
        format.html { redirect_to person_path(@payment.main_member)  }
      else
        flash[:warning] = 'delete failed.'
        format.html { redirect_to(person_path(@payment.main_member)) }
      end
    end
  end
  #=======================================
  def list_by_member_class
  #  this_yr_start = Time.now.year.to_s + "-01-01"
    this_yr_start = Time.now.beginning_of_year
    @payments = Payment.all.
      includes(:privilege).
      where("paymenttype_id in ('1','4','5') and  date_lodged > ? ", this_yr_start).
      order('privileges.name, date_lodged')
  end

  #=======================================
  def tot_by_member_class_2
    @totals = Payment.
      select("count(*) as count, sum(payments.amount) as total_amount, privileges.name as privilege_name, paymenttypes.name as payname, date_lodged").
      group([:date_lodged,:privilege_id,'privileges.name, paymenttypes.name']).
      joins(:privilege,:paymenttype)
     @totals_years = @totals.group_by{ |t| t.date_lodged.beginning_of_year }
    #@counts = Payment.count(:group => [:date_lodged,:privilege_id])
    #@payments = Payment.group()
    #group_by{ |t| t.date_lodged.beginning_of_year }
    endmonth =   Time.now.month.to_s
    endday =     Time.now.day.to_s
    @chart_to_date = Payment.g_chart_mems(endmonth,endday)
    puts Payment.g_chart_mems(endmonth,endday)
  end


def tot_by_member_class

    @years = 5
    @month = ''
    @typestd = []
    @yeartotaltd = []
    @types = []
    @yeartotal = []
    @memtotaltd = []
    @memtotalyear = []
      endmonth =   Time.now.month.to_s
      endday =     Time.now.day.to_s

    if params[:commit] == 'Go'
      if params[:date][:month].to_i >  0
        endmonth =   params[:date][:month].to_s
        endday = (Time.now.year.to_s + '-' + endmonth + '-01').to_date.end_of_month.day.to_s
      end
    end
    @end_month = endmonth.to_i
    #@years.times do |y|
  #start_date = Time.now.years_ago(5).beginning_of_year
  #end_date = ((Time.now.year).to_s + "." + endmonth + "." + endday).to_date 
  #@typestd =  Payment.yttypes( start_date,end_date).merge(Payment.rttypes( start_date,end_date))
    #  @yeartotaltd = Payment.year_total( start_date,end_date).select( "COUNT(*) as tot, SUM(amount) as money")
    #  @memtotaltd  = Payment.members_year_total( start_date,end_date).select( "COUNT(*) as count"   )
  #start_date =  Time.now.years_ago(5).beginning_of_year
  #end_date   =  Time.now.end_of_year
   #   @types = Payment.yttypes( start_date,end_date ).merge(Payment.rttypes( start_date,end_date ))
      #TODO - do I need the left outer join in  below 2 statements ? 
     # @yeartotal = Payment.year_total( start_date,end_date ).select( "COUNT(*) as tot, SUM(amount) as money")
     # @memtotalyear = Payment.members_year_total( start_date,end_date ).select( "COUNT(*) as count"   )
   #end
   @chart_to_date = Payment.g_chart_mems(endmonth,endday)
end

  def listytd
    @payments = Payment.current_year.includes(:member,:privilege,:payment_method,:paymenttype)
    respond_to do |format|
      format.html
      format.xml { render :xml=>@payments }
    end
  end


 def overduememberships
   @overdues = Member.overduesubs
   if params[:commit] == 'Export CSV file'
     extract = CSV.generate do |csv|
       csv << ['First Name', 'Last Name', 'Home Phone', 'Mobile', 'Email','name_no','Street1','Street2','Town','City', 'Postcode','County','Country','Member Class', 'Age', 'last Payment date']
       @overdues.each do |c|
          csv << [c.people[0].first_name, c.people[0].last_name, c.people[0].home_phone, c.people[0].mobile_phone, c.people[0].email_address, c.name_no,c.street1,c.street2,c.town,c.city,c.postcode,c.county,c.country,c.privilege.name ,c.people[0].age,  c.renew_date.to_date]
       end
     end
    send_data(extract,:type => 'text/csv; charset=iso-8859-1; header=present',:filename => 'overduemembers.csv', :disposition => 'attachment', :encoding => 'utf8')
   end
 end




  def overdue_csv
  @overdue = Member.overduesubs
  report = StringIO.new
  CSV::Writer.generate(report,',') do |title|

  title << ['First Name', 'Last Name', 'Home Phone', 'Mobile', 'Email','Address1','Address2','Address3','Address4',
    'Member Class', 'Age', 'last Payment date']
    @overdue.each do |c|
      title << [c.people[0].first_name, c.people[0].last_name, c.people[0].home_phone, c.people[0].mobile_phone,
        c.people[0].email_addr, c.address1,c.address2,c.address3,c.address4,c.privilege.name ,
        c.people[0].age,c.renew_date.to_date]
    end
  end
  report.rewind
  send_data(report.read,:type => 'text/csv; charset=iso-8859-1; header=present',:filename => 'overduemembers.csv',
    :disposition => 'attachment', :encoding => 'utf8')
  end

  def receipts_breakdown
    #Start year is 2007
    @years = Time.now.year - 2006 + 1
    @month = ''
    @paytypestd = []
    @paytypestotaltd = []

    if params[:commit] == 'Go'
      if params[:date][:month].to_i == 0
        @month =   Time.now.month.to_s
        endday =     Time.now.day.to_s
      end
      @month =   params[:date][:month].to_s
      endday =     "31"
   else
      @month =   Time.now.month.to_s
      endday =     Time.now.day.to_s
    end

    @years.times do |y|
      date_start = (Time.now.year - y).to_s + "." + @month + ".01"
      date_end =   (Time.now.year - y).to_s + "." + @month + "." + endday
     @paytypestd[y]  = Payment.
                          select("month(date_lodged) as month, monthname(date_lodged) as monthname, count(*) as transactions,  pay_type, sum(amount) as sum").
                          joins("inner join privileges ON privileges.id = payments.privilege_id left outer join paymenttypes on payments.paymenttype_id = paymenttypes.id").
        where("date_lodged >= ? AND date_lodged <= ? and member_class not in ('X','Y') and paymenttypes.id in ('1','4','5') ", date_start, date_end ).
                          group("pay_type, month, monthname").
                          order("month, pay_type")

     @paytypestotaltd[y]  = Payment.
                          select("month(date_lodged) as month, monthname(date_lodged) as monthname, count(*) as transactions, sum(amount) as sum").
                          joins("inner join privileges ON privileges.id = payments.privilege_id left outer join paymenttypes on payments.paymenttype_id = paymenttypes.id").
                          where("date_lodged >= ? AND date_lodged <= ? and member_class not in ('X','Y') and paymenttypes.id in ('1','4','5') ", date_start, date_end ).
                          group("month, monthname").
                          order("month, pay_type")
     end
  end

  def drill_pay
    #@drill = []
    date_start = Date.new(params[:year].to_i,params[:month].to_i,'01'.to_i).to_date
    date_end = date_start.end_of_month
      @pay_type = params[:pay_type].to_s
     @drill  = Payment.
    select("month(date_lodged) as month, monthname(date_lodged) as monthname, count(*) as transactions,  pay_type, sum(amount) as sum").
    joins("inner join privileges ON privileges.id = payments.privilege_id left outer join paymenttypes on payments.paymenttype_id = paymenttypes.id").
    where("date_lodged >= '?' AND date_lodged <= '?' and member_class not in ('X','Y') and paymenttypes.id in ('1','4','5')", date_start, date_end).
    group("pay_type, month, monthname").
    order("month, pay_type")

     #@paytypestotaltd[y]  = Payment.find :all,
     #                     :select => "month(date_lodged) as month, monthname(date_lodged) as monthname, count(*) as transactions, sum(amount) as sum",
     #                     :joins => "inner join privileges ON privileges.id = payments.privilege_id", 
     #                     :conditions => "date_lodged >= '#{date_start}' AND date_lodged <= '#{date_end}' and member_class not in ('X','Y') ",
     #                     :group => "month, monthname",
     #                     :order => "month, pay_type"

     respond_to do |format|
         format.html
         format.xml
         format.json
    end
  end

  def auto_renew_life_honorary
    @renews = Member.memclass(5,6)
    @renews.each do |renew|
      @payment = Payment.new
      @payment.member_id  = renew.id
      @payment.amount = 0
      @payment.date_lodged = 1.year.from_now.beginning_of_year
      #renew.renew_date = @payment.date_lodged
      #@renew.save
      @payment.privilege_id = renew.privilege.id
      @pid = Person.main_person(renew.id)
      #default to Subscription renewal
      @payment.pay_type = 'NP'
      @payment.paymenttype_id = 1
      @payment.comment ="Auto Renewed by System"
      @payment.save
      if @payment.save
        renew.renew_date = @payment.date_lodged
        @renew.save
        flash[:notice] = 'Members Renewed'
       else
         flash[:notice] = 'Error'
       end
    end
  end

  private
  def set_model
    @payment = Payment.find(params[:id])
  end

  def payment_params
  params.require(:payment).permit(:member_id,:amount,:date_lodged,:pay_type,:comment,
    :privilege_id,:paymenttype_id,:payment_method_id)
  end

end

