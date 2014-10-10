class PaymentsController < ApplicationController
  require 'csv'
 #verify :method => :post, :only => [ :destroy, :create, :update ]
  after_filter :check_privilege_and_renewal_date, :only => [:update,:create]
  #=======================================
  def edit
    @payment = Payment.find(params[:id])
    @m = @payment.member
    @person = Person.main_person(@payment.member_id)
  end
  
  #=======================================
  def list_by_member_class
  #  this_yr_start = Time.now.year.to_s + "-01-01"  
    this_yr_start = Time.now.beginning_of_year 
    @payments = Payment.find :all,  :include => :privilege ,:conditions => "paymenttype_id in ('1','4','5') and  date_lodged > '#{this_yr_start}'", :order => 'privileges.name, date_lodged' 
  end
  
  #=======================================
  def tot_by_member_class_2
    @totals = Payment.
      select("count(*) as count, sum(payments.amount) as total_amount, privileges.name as privilege_name, paymenttypes.name as payname, date_lodged").
      group([:date_lodged,:privilege_id,'privileges.name, paymenttypes.name']).
      joins(:privilege,:paymenttype)
    
     @totals_years = @totals.group_by{ |t| t.date_lodged.beginning_of_year }
    
    
#    @counts = Payment.count(:group => [:date_lodged,:privilege_id])
   # @payments = Payment.group()
    
      #group_by{ |t| t.date_lodged.beginning_of_year }
 
     endmonth =   Time.now.month.to_s
      endday =     Time.now.day.to_s
    @chart_to_date = Payment.g_chart_mems(endmonth,endday)
    puts Payment.g_chart_mems(endmonth,endday)
  
  
  
  
  end

  
def tot_by_member_class
    
    #Start year is 2007
    
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
    
    @years.times do |y|
      
          
      date_start = (Time.now.year - y).to_s + "-01-01"
      date_end = (Time.now.year - y).to_s + "." + endmonth + "." + endday
      
find_sql =   " select renewals.tot,pays.tot as paytot, pays.money, pays.name from 
(

SELECT   member_class,
         COUNT(*) as tot,
         SUM(amount) as money,
         privileges.name
        
FROM     payments
         inner join privileges ON privileges.id = payments.privilege_id 
         left outer join paymenttypes on payments.paymenttype_id = paymenttypes.id
WHERE    (date_lodged >= '#{date_start}'
     AND date_lodged <= '#{date_end}'
     AND privileges.member_class not in ('X','Y')
     AND paymenttypes.id in ('1','4'))
GROUP BY member_class, privileges.name
ORDER BY member_class
) as renewals
,
(

SELECT   member_class,
         COUNT(*) as tot,
         SUM(amount) as money,
         privileges.name as name
       
FROM     payments 
         inner join privileges ON privileges.id = payments.privilege_id 
         left outer join paymenttypes on payments.paymenttype_id = paymenttypes.id
WHERE    (date_lodged >= '#{date_start}'
     AND date_lodged <= '#{date_end}'
     AND privileges.member_class not in ('X','Y')
     AND paymenttypes.id in ('1','4','5'))
GROUP BY member_class, privileges.name
ORDER BY member_class

) pays

where pays.member_class = renewals.member_class"

 
total_mem_sql =   "SELECT   
         COUNT(*) as count
FROM     payments
         inner join privileges ON privileges.id = payments.privilege_id 
         left outer join paymenttypes on payments.paymenttype_id = paymenttypes.id
WHERE    (date_lodged >= '#{date_start}'
    AND date_lodged <= '#{date_end}'
     AND privileges.member_class not in ('X','Y')
     AND paymenttypes.id in ('1','4'))"     
    
     
      @typestd[y] = Payment.find_by_sql(find_sql)

     @yeartotaltd[y] = Payment.find  :all,  
                          :select => "COUNT(*) as tot, SUM(amount) as money",
                          :joins => "inner join privileges ON privileges.id = payments.privilege_id left outer join paymenttypes on payments.paymenttype_id = paymenttypes.id", 
                          :conditions => " date_lodged >= '#{date_start}' AND date_lodged <= '#{date_end}' and member_class not in ('X','Y') and paymenttypes.id in ('1','4','5') "
    
    @memtotaltd[y] = Payment.find_by_sql(total_mem_sql)


     date_start = (Time.now.year - y).to_s + "-01-01"
     date_end = (Time.now.year - y).to_s + "-12-31" 
     
  find_sql =   " select renewals.tot,pays.tot as paytot, pays.money, pays.name from 
(

SELECT   member_class,
         COUNT(*) as tot,
         SUM(amount) as money,
         privileges.name
        
FROM     payments
         inner join privileges ON privileges.id = payments.privilege_id 
         left outer join paymenttypes on payments.paymenttype_id = paymenttypes.id
WHERE    (date_lodged >= '#{date_start}'
     AND date_lodged <= '#{date_end}'
     AND privileges.member_class not in ('X','Y')
     AND paymenttypes.id in ('1','4'))
GROUP BY member_class, privileges.name
ORDER BY member_class
) as renewals
,
(

SELECT   member_class,
         COUNT(*) as tot,
         SUM(amount) as money,
         privileges.name as name
       
FROM     payments 
         inner join privileges ON privileges.id = payments.privilege_id 
         left outer join paymenttypes on payments.paymenttype_id = paymenttypes.id
WHERE    (date_lodged >= '#{date_start}'
     AND date_lodged <= '#{date_end}'
     AND privileges.member_class not in ('X','Y')
     AND paymenttypes.id in ('1','4','5'))
GROUP BY member_class, privileges.name
ORDER BY member_class

) pays

where pays.member_class = renewals.member_class"
   
  total_mem_sql =   "SELECT   
         COUNT(*) as count
FROM     payments
         inner join privileges ON privileges.id = payments.privilege_id 
         left outer join paymenttypes on payments.paymenttype_id = paymenttypes.id
WHERE    (date_lodged >= '#{date_start}'
    AND date_lodged <= '#{date_end}'
     AND privileges.member_class not in ('X','Y')
     AND paymenttypes.id in ('1','4'))"     
     @types[y] = Payment.find_by_sql(find_sql)

     @yeartotal[y] = Payment.find  :all,  
                          :select => "COUNT(*) as tot, SUM(amount) as money",
                          :joins => "inner join privileges ON privileges.id = payments.privilege_id left outer join paymenttypes on payments.paymenttype_id = paymenttypes.id", 
                          :conditions => "date_lodged >= '#{date_start}' AND date_lodged <= '#{date_end}' and member_class not in ('X','Y') and paymenttypes.id in ('1','4','5') "
     @memtotalyear[y] = Payment.find_by_sql(total_mem_sql)

     end

    
    @chart_to_date = Payment.g_chart_mems(endmonth,endday)

end




  
  #=======================================
  
  def listytd
    
    dt_strt = (Time.now.year-1).to_s + "-12-31"
    
    @payments = Payment.all :select => 'payment_type,amount,privileges.name,people.last_name,people.first_name ', :include => [{:member => :people},:privilege], 
   
    :conditions => "date_lodged > '#{dt_strt}' and status = 'm'  " , :order => 'date_lodged' 
    session[:listpath] = session[:jumpcurrent]
    respond_to do |format|
      format.html
      format.xml { render :xml=>@payments } 
      
    end
  end
  
 
  #=======================================
   def update
     @payment = Payment.find(params[:id])
     @person = Person.main_person(@payment.member_id)
     respond_to do |format|
       if @payment.update_attributes(params[:payment])
         format.html { redirect_to edit_person_path(@person.id) } 
         if changed_privilege?  
           flash[:notice] = 'Payment Successfully Updated, Membership Class updated.'
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
    @payment.privilege_id = Member.membership(params[:member_id]).privilege.id
    @person = Person.main_person(@payment.member_id)
    #default to Subscription renewal
    @payment.paymenttype_id = 1
    @payment.date_lodged = Time.now.to_date
    
  end 
  def create
    @payment = Payment.new(params[:payment])
    @member = Member.membership(params[:payment][:member_id])
    @person = Person.main_person(params[:payment][:member_id])
    respond_to do |format|
      if @payment.save 
        if changed_privilege?  
          flash[:notice] = 'Payment Successfully Created, Membership Class updated.'
        else
          flash[:notice] = 'Payment Successfully Created'
        end  
        format.html { redirect_to :controller =>'people', :action => 'edit',:id => @person.id }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  
  
  
  
  
  
  def destroy
    pm = Payment.find(params[:id])
     #m = Member.find(pm.member_id)       #  :first ,:conditions => "id = '#{pm.member_id}'"
    m = pm.member_id.id
     @person = Person.main_person(pm.member_id)
     pm.destroy
    if pm.paymenttype_id == 1 or pm.paymenttype_id == 4
      prevpay = Payment.find :first,:conditions => "member_id = '#{pm.member_id}' and paymenttype_id in (1,4)  ",:order => "date_lodged DESC " rescue nil
      if prevpay and prevpay.date_lodged !=  m.renew_date 
            m.renew_date = prevpay.date_lodged 
            m.save!
            flash[:notice] = 'Payment Deleted - Resetting renewed date.' 
          if prevpay and prevpay.privilege_id != m.privilege_id
               m.privilege_id = prevpay.privilege_id
               m.save!
               flash[:notice] = 'Warning; Resetting membership type to that of previous payment.' 
          end
      else 
        flash[:notice] = 'Payment Deleted'
      end
  else
        flash[:notice] = 'Payment Deleted'
  end
      
 redirect_to :controller =>'people', :action => 'edit',:id => @person.id
  
 
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

  title << ['First Name', 'Last Name', 'Home Phone', 'Mobile', 'Email','Address1','Address2','Address3','Address4', 'Member Class', 'Age', 'last Payment date']
    @overdue.each do |c|
      title << [c.people[0].first_name, c.people[0].last_name, c.people[0].home_phone, c.people[0].mobile_phone, c.people[0].email_addr, c.address1,c.address2,c.address3,c.address4,c.privilege.name ,c.people[0].age,  c.renew_date.to_date]
    end

  end
  report.rewind
  send_data(report.read,:type => 'text/csv; charset=iso-8859-1; header=present',:filename => 'overduemembers.csv', :disposition => 'attachment', :encoding => 'utf8')



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
      
     @paytypestd[y]  = Payment.find :all, 
                          :select => "month(date_lodged) as month, monthname(date_lodged) as monthname, count(*) as transactions,  pay_type, sum(amount) as sum",
                          :joins => "inner join privileges ON privileges.id = payments.privilege_id left outer join paymenttypes on payments.paymenttype_id = paymenttypes.id", 
                          :conditions => "date_lodged >= '#{date_start}' AND date_lodged <= '#{date_end}' and member_class not in ('X','Y') and paymenttypes.id in ('1','4','5') ",
                          :group => "pay_type, month, monthname",
                          :order => "month, pay_type"
  
   
     @paytypestotaltd[y]  = Payment.find :all, 
                          :select => "month(date_lodged) as month, monthname(date_lodged) as monthname, count(*) as transactions, sum(amount) as sum",
                          :joins => "inner join privileges ON privileges.id = payments.privilege_id left outer join paymenttypes on payments.paymenttype_id = paymenttypes.id", 
                          :conditions => "date_lodged >= '#{date_start}' AND date_lodged <= '#{date_end}' and member_class not in ('X','Y') and paymenttypes.id in ('1','4','5') ",
                          :group => "month, monthname",
                          :order => "month, pay_type"


     end
end

def drill_pay
    
    
    #@drill = []
    
    date_start = Date.new(params[:year].to_i,params[:month].to_i,'01'.to_i).to_date
    date_end = date_start.end_of_month
      @pay_type = params[:pay_type].to_s
      
   
      
     @drill  = Payment.find :all, 
                          :select => "month(date_lodged) as month, monthname(date_lodged) as monthname, count(*) as transactions,  pay_type, sum(amount) as sum",
                          :joins => "inner join privileges ON privileges.id = payments.privilege_id left outer join paymenttypes on payments.paymenttype_id = paymenttypes.id", 
                          :conditions => "date_lodged >= '#{date_start}' AND date_lodged <= '#{date_end}' and member_class not in ('X','Y') and paymenttypes.id in ('1','4','5')",
                          :group => "pay_type, month, monthname",
                          :order => "month, pay_type"
  
    logger.info "here"
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

  def check_privilege_and_renewal_date
    if (@payment.date_lodged.year == Time.now.year)  &&  renewal_payment
      @person.member.privilege_id = @payment.privilege_id if changed_privilege?
      @person.member.renew_date = @payment.date_lodged
      @person.member.save 
    end
  end

def renewal_payment
    @payment.paymenttype_id == 1 or @payment.paymenttype_id == 4 
 end

def changed_privilege?
      @payment.member.privilege != @payment.privilege 
 end




end

