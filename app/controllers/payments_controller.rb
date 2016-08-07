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
        format.js
        if @payment.changed_privilege?
          @payment.update_member_privilege
          flash[:notice] = 'Payment Successfully Updated, Membership Class Updated.'
        else
          flash[:notice] = 'Payment Successfully Updated'
          format.js
        end
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def new
    @payment = Payment.new
    @payment.member_id = params[:member_id]
    @payment.privilege_id = @payment.member.privilege.id
    # default to Subscription renewal
    @payment.paymenttype_id = 1
    @payment.date_lodged = Time.now.to_date
  end

  def create
    @payment = Payment.new(payment_params)
    respond_with(@payment, location: person_path(@payment.main_member) + '#tabs-1') do |format|
      if @payment.save
        @payment.check_renewal_date
        if @payment.changed_privilege?
          @payment.update_member_privilege
          flash[:notice] = 'Payment Successfully Processed -  Membership Class Updated'
        else
          flash[:notice] = 'Payment Successfully Processed'
          format.js
        end
      else
        format.html { render action: 'new' }
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      if @payment.destroy
        # set the default flash notice
        flash[:notice] = 'Payment was successfully deleted.'
        flash[:notice] = @payment.delete_checks unless @payment.delete_checks.blank?
      else
        flash[:warning] = 'delete failed.'
      end
      format.html { redirect_to person_path(@payment.main_member) }
    end
  end

  def list_by_member_class
    this_yr_start = Time.now.utc.beginning_of_year
    @payments = Payment.all
                       .includes(:privilege)
                       .where("paymenttype_id in ('1','4','5') and  date_lodged > ? ", this_yr_start)
                       .order('privileges.name, date_lodged')
  end

  def tot_by_member_class
    @years = 0..4
    @month = ''
    @typestd = []
    @yeartotaltd = []
    @types = []
    @yeartotal = []
    @memtotaltd = []
    @memtotalyear = []
    endmonth =   Time.now.utc.month.to_s
    endday =     Time.now.utc.day.to_s

    if params[:commit] == 'Go'
      if params[:date][:month].to_i > 0
        endmonth = params[:date][:month].to_s
        endday = (Time.now.utc.year.to_s + '-' + endmonth + '-01').to_date.end_of_month.day.to_s
      end
    end
    @end_month = endmonth.to_i
    @years.each do |y|
      start_date = Time.now.utc.years_ago(y).beginning_of_year
      end_date = (Time.now.utc.years_ago(y).year.to_s + '.' + endmonth + '.' + endday).to_date
      @typestd[y] = Payment.yttypes(start_date, end_date).merge(Payment.rttypes(start_date, end_date))
      @yeartotaltd[y] = Payment.year_total(start_date, end_date).select('COUNT(*) as tot, SUM(amount) as money')
      @memtotaltd[y]  = Payment.members_year_total(start_date, end_date).select('COUNT(*) as count')
      start_date =  Time.now.utc.years_ago(y).beginning_of_year
      end_date   =  Time.now.utc.years_ago(y).end_of_year
      @types[y] = Payment.yttypes(start_date, end_date).merge(Payment.rttypes(start_date, end_date))
      # TODO: - do I need the left outer join in  below 2 statements ?
      @yeartotal[y] = Payment.year_total(start_date, end_date).select('COUNT(*) as tot, SUM(amount) as money')
      @memtotalyear[y] = Payment.members_year_total(start_date, end_date).select('COUNT(*) as count')
    end
    @chart_to_date = Payment.g_chart_mems(endmonth, endday)
    render 'tot_by_member_class'
  end

  def listytd
    @payments = Payment.current_year.includes(:privilege, :payment_method, :paymenttype, [member: :people])
  end

  def overduememberships
    @overdues = Member.overduesubs.includes(:people, :privilege)
    # if params[:commit] == 'Export CSV file'
    extract = CSV.generate do |csv|
      csv << ['First Name', 'Last Name', 'Home Phone', 'Mobile', 'Email', 'name_no', 'Street1', 'Street2', 'Town', 'City', 'Postcode', 'County', 'Country', 'Member Class', 'Age', 'last Payment date']
      @overdues.each do |c|
        csv << [c.people[0].first_name, c.people[0].last_name, c.people[0].home_phone, c.people[0].mobile_phone, c.people[0].email_address, c.name_no, c.street1, c.street2, c.town, c.city, c.postcode, c.county, c.country, c.privilege.name, c.people[0].age, c.renew_date.to_date]
      end
    end
    send_data(extract, type: 'text/csv; charset=iso-8859-1; header=present', filename: 'overduemembers.csv', disposition: 'attachment', encoding: 'utf8')
    # end
  end

  def overdue_csv
    @overdue = Member.overduesubs
    report = StringIO.new
    CSV::Writer.generate(report, ',') do |title|
      title << ['First Name', 'Last Name', 'Home Phone', 'Mobile', 'Email', 'Address1', 'Address2', 'Address3', 'Address4',
                'Member Class', 'Age', 'last Payment date']
      @overdue.each do |c|
        title << [c.people[0].first_name, c.people[0].last_name, c.people[0].home_phone, c.people[0].mobile_phone,
                  c.people[0].email_addr, c.address1, c.address2, c.address3, c.address4, c.privilege.name,
                  c.people[0].age, c.renew_date.to_date]
      end
    end
    report.rewind
    send_data(report.read, type: 'text/csv; charset=iso-8859-1; header=present', filename: 'overduemembers.csv',
                           disposition: 'attachment', encoding: 'utf8')
  end

  def receipts_breakdown
    @years = Time.now.utc.year - 2006 + 1
    @month = ''
    @paytypestd = []
    @paytypestotaltd = []

    if params[:commit] == 'Go'
      if params[:date][:month].to_i == 0
        @month = Time.now.utc.month.to_s
        endday = Time.now.utc.day.to_s
      end
      @month = params[:date][:month].to_s
      endday = '31'
    else
      @month = Time.now.utc.month.to_s
      endday = Time.now.utc.day.to_s
    end

    @years.times do |y|
      date_start = (Time.now.utc.year - y).to_s + '.' + @month + '.01'
      date_end =   (Time.now.utc.year - y).to_s + '.' + @month + '.' + endday
      @paytypestd[y] = Payment
                       .select('month(date_lodged) as month, monthname(date_lodged) as monthname, count(*) as transactions,  pay_type, sum(amount) as sum')
                       .joins('inner join privileges ON privileges.id = payments.privilege_id left outer join paymenttypes on payments.paymenttype_id = paymenttypes.id')
                       .where("date_lodged >= ? AND date_lodged <= ? and member_class not in ('X','Y') and paymenttypes.id in ('1','4','5') ", date_start, date_end)
                       .group('pay_type, month, monthname')
                       .order('month, pay_type')

      @paytypestotaltd[y] = Payment
                            .select('month(date_lodged) as month, monthname(date_lodged) as monthname, count(*) as transactions, sum(amount) as sum')
                            .joins('inner join privileges ON privileges.id = payments.privilege_id left outer join paymenttypes on payments.paymenttype_id = paymenttypes.id')
                            .where("date_lodged >= ? AND date_lodged <= ? and member_class not in ('X','Y') and paymenttypes.id in ('1','4','5') ", date_start, date_end)
                            .group('month, monthname')
                            .order('month, pay_type')
    end
  end

  private

  def set_model
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:member_id, :amount, :date_lodged, :pay_type, :comment,
                                    :privilege_id, :paymenttype_id, :payment_method_id)
  end
end
