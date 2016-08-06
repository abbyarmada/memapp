class PeopleController < ApplicationController
  require 'csv'
  before_action :check_search_form_reset, only: [:index]
  before_action :set_model, only: [:update, :destroy, :cut, :renewal_email, :newmember]
  before_action :set_model_with_payment_and_barcards, only: [:show, :edit]
  respond_to :html, :pdf

  def show
    @member = Member.find(@person.member_id) # required for membership form
    respond_to do |format|
      format.html
      format.pdf do
        pdf = PersonPdf.new(@person)
        send_data pdf.render, filename: "#{@person.last_name}_#{@person.first_name}.pdf",
                              type: 'application/pdf',
                              disposition: 'inline'
      end
    end
  end

  def create_renewals
    last_yr_start = (Time.now.year - 1).to_s + '-01-01'
    @renews = Person.all
                    .includes(:member)
                    .where("people.status = 'm' and ( members.renew_date  >= ? or members.year_joined = Year(CURDATE())  ) AND privilege_id = 5", last_yr_start)

    @renews.each do |person|
      @person = person
      pdf = PersonPdf.new(@person, view_context)
      send_data pdf.render, filename: "#{@person.last_name}_#{@person.first_name}.pdf", type: 'application/pdf'
    end
  end

  def index
    @people = Person.search(params)
    session[:search] = session[:jumpcurrent]
  end

  def new
    @person = Person.new # (person_params)
    @person.member_id = params[:member_id]
    @barcard = Barcard.new
    @peoplebarcard = Peoplebarcard.new
    @peoplebarcard.person_id = @person.id
    @peoplebarcard.barcard_id = @barcard.id
  end

  def create
    @person = Person.new(person_params)
    @barcard = Barcard.new(person_params[:barcard])
    @peoplebarcard = Peoplebarcard.new(params[:peoplebarcard])
    respond_to do |format|
      if @person.save
        if @person.status != 'g'
          @barcard.save
          @peoplebarcard.barcard_id = @barcard.id
          @peoplebarcard.person_id = @person.id
          @peoplebarcard.save
        end
        flash[:notice] = 'Person successfully created.'
        format.html { redirect_to person_path(@person) + '#tabs-3' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def edit
  end

  def update
    @person.update(person_params)
    respond_to do |format|
      if @person.save
        flash[:notice] = 'Person was successfully updated.'
        format.html { redirect_to person_path + '#tabs-3' }
      else
        flash[:error] = 'Person could not be updated due to an error.'
        format.html { render action: 'edit', id: @person.id }
        # redirect_to  person_path(Person.main_person(@member.id))  + '#tabs-2'
      end
    end
  end

  def destroy
    @main_member = Person.main_person(@person.member_id)
    if @person.status == 'm'
      # redirect_to :back
      flash[:error] = 'Cannot delete the Main Member.'
      redirect_to person_path(@person) + '#tabs-3'
    else
      @person.destroy
      respond_to do |format|
        format.html { redirect_to person_url(@main_member.id) + '#tabs-3', notice: 'Person was successfully deleted.' }
      end
    end
  end

  def cut
    session[:copypersonid] = @person.id
    session[:copypersonmid] = @person.member_id
    redirect_to person_path(@person) + '#tabs-3'
    flash[:notice] = 'Person Cut to memory, go to other membership and select paste.'
  end

  def newmember
    @newmember = Member.new
    @newmember = @person.member.dup
    if @newmember.save
      @person.member_id = @newmember.id
      @person.save
      redirect_to person_path(@person) + '#tabs-3'
      flash[:notice] = 'Person moved to a newly created Membership.'
    else
      redirect_to :back
      flash[:notice] = 'Oops.. something went wrong..'
    end
  end

  def paste
    @person = Person.find(session[:copypersonid])
    @person.member_id = params[:member_id]
    @person.status = 'ch'
    if @person.save
      session[:copypersonid] = ''
      redirect_to person_path(@person) + '#tabs-3'
      flash[:notice] = 'Person Moved to this membership'
    else
      redirect_to :back
      flash[:notice] = 'An Error occured while moving this person to this membership'
    end
  end

  def renewal_email
    RenewalMailer.renewal_letter(@person).deliver_now
    redirect_to :back, flash: { success: 'Renewal sent via Email' }
  end

  def paid_up_extract_current
    date = Time.now.year.to_s + '-01-01'
    filename = 'PaidupExtract.csv'
    type = 'Paidup'
    bar_interface2(date, filename, type)
  end

  # def paid_up_extract_last_year
  #   date = (Time.now.year - 1).to_s + '-01-01'
  #   filename = 'PaidupExtractLastYear.csv'
  #   type = 'Paidup'
  #   bar_interface2(date, filename, type)
  # end
  #
  # def paid_up_extract_two_year_ago
  #   date = (Time.now.year - 2).to_s + '-01-01'
  #   filename = 'PaidupExtractTwoYearsAgo.csv'
  #   type = 'Paidup'
  #   bar_interface2(date, filename, type)
  # end
  #
  # def paid_up_extract_three_year_ago
  #   date = (Time.now.year - 3).to_s + '-01-01'
  #   filename = 'PaidupExtractThreeYearsAgo.csv'
  #   type = 'Paidup'
  #   bar_interface2(date, filename, type)
  # end
  #
  # def paid_up_extract_four_year_ago
  #   date = (Time.now.year - 4).to_s + '-01-01'
  #   filename = 'PaidupExtractFourYearsAgo.csv'
  #   type = 'Paidup'
  #   bar_interface2(date, filename, type)
  # end
  #
  # def paid_up_extract_five_year_ago
  #   date = (Time.now.year - 5).to_s + '-01-01'
  #   filename = 'PaidupExtractFiveYearsAgo.csv'
  #   type = 'Paidup'
  #   bar_interface2(date, filename, type)
  #  end

  def bar_interface
    date = (Time.now.year - 1).to_s + '-01-01'
    filename = 'BarInterface.csv'
    type = 'Bar'
    bar_interface2(date, filename, type)
  end

  def bar_interface2(date, filename, type)
    if type == 'Bar'
      @people = Person.all
                      .includes(:member, :peoplebarcard).references(:members, :peopbbarcards)
                      .where('members.renew_date >= ? ', date)
                      .order('people.id,last_name,first_name')
    else
      enddate = date.slice(0, 4) + '-12-31'
      @people = Person.all.includes(:member, :peoplebarcard, :payments)
                      .where(' payments.paymenttype_id in (1,4,5) and payments.date_lodged >= ? and payments.date_lodged <= ?  ', date, enddate)
                      .order('people.id,last_name,first_name')
    end
    extract = CSV.generate do |csv|
      # header row
      csv << %w(BarBillies MemClass CardNo LastName FirstName MemNumber
                Salutation HouseNameNo StreetAddr StreetAddr2 Town City PostCode County Country
                RenewedCurrentYear RenewedDate dob occupation
                HomePhone Mobile Email Social Racing Cruiser Dinghy Junior MembershipId member_type)
      @people.each do |p|
        # privilege = Privilege.find_by_id p.member.privilege_id
        barreference = p.privilege.bar_reference if type == 'Bar'
        barreference = p.privilege.name if type == 'Paidup'
        salutation = ''
        renewedcurrentyear = ''
        # bar billies, based on member class  defaulted to N, set to Y if member class allows
        # and membership renewed.
        # new members do not get bar billies.
        bar_billies = 'N'
        renewedcurrentyear = 'N'
        if p.member.renew_date.year == Time.now.year
          renewedcurrentyear = 'Y'
          if p.status == 'm' && p.member.renew_date < Privilege.billie_cutoff_date
            bar_billies = p.privilege.bar_billies
          end
        end
        occupation = ''
        occupation = p.member.occupation if p.status == 'm'
        social = 'X' unless p.txt_social == 0
        racing = 'X' unless p.txt_crace == 0
        cruising = 'X' unless p.txt_cruising == 0
        dinghy = 'X' unless p.txt_dinghy_sailing == 0
        junior = 'X' unless p.txt_junior == 0
        barcard = ''
        barcd = begin
                  p.peoplebarcard.barcard_id || 0000
                rescue
                  nil
                end

        begin
          barcard = (ENV['BARCARD_PREFIX'] + '%05d' % barcd).to_s if p.peoplebarcard.barcard_id
        rescue
          nil
        end
        next unless barreference != 0 && p.status != 'g'
        csv << [bar_billies, barreference, barcard, p.last_name, p.first_name, p.id,
                p.salutation,
                p.member.name_no,
                p.member.street1,
                p.member.street2,
                p.member.town,
                p.member.city,
                p.member.postcode,
                p.member.county,
                p.member.country,
                renewedcurrentyear, p.member.renew_date.to_date.to_s, p.dob, occupation,
                p.home_phone, p.mobile_phone, p.email_address, social, racing, cruising, dinghy, junior, p.member.id, p.status]
      end
    end # do csv
    send_data(extract, type: 'text/csv; charset=iso-8859-1; header=present', filename: filename, disposition: 'attachment', encoding: 'utf8')

    # end #if
  end # def

  def check_search_form_reset
    if params[:commit] == 'Reset'
      params[:search] = ''
      params[:searchfn] = ''
      params[:searchmp][:privilege_id] = ''
      params[:group] = false
      params[:past_members] = false
    end
  end

  def set_model
    @person = Person.find(params[:id])
  end

  def set_model_with_payment_and_barcards
    @person = Person.includes(:peoplebarcard, :loyaltycard, [payments: [:paymenttype, :privilege, :payment_method]]).find(params[:id])
  end

  def person_params
    params.require(:person)
          .permit(
            :member_id,
            :first_name, :last_name, :status,
            :home_phone, :mobile_phone, :email_address,
            :comm_prefs, :snd_txt, :snd_eml,
            :dob,
            :txt_bridge, :txt_social, :txt_crace, :txt_cruiser_race_skipper, :txt_cruising,
            :txt_cruiser_skipper, :txt_dinghy_sailing, :txt_junior, :txt_test, :txt_op_co,
            :occupation,
            :send_txt, :send_email
          )
  end
end # class
