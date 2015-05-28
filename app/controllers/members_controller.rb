class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]


  def index
    @members = Member.all
  end

  def show
  end

  def new
    @member = Member.new
    @member.people.build
    @member.year_joined = Time.now.year
    @member.privilege = Privilege.find_by_name "Applicant"
	  @member.active = true
  end

  def edit
  end

  def create
    @member = Member.new(member_params)
    respond_to do |format|
      if @member.save
        @member.complete_new_member_process
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render action: 'show', status: :created, location: @member }
      else
        format.html { render action: 'new', notice: 'Member was not created - fix errors .' }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member.main_member, notice: 'Member was successfully updated.' }
      else
        format.html { render action: 'edit' }

      end
    end
  end

  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url ,notice: 'Member was successfully deleted.'}
      format.json { head :no_content }
    end
  end


  def carpark_passes
    process_carpark_passes
  end

  private

  def process_carpark_passes
    @mems = Member.current_members.parking_members  #.all #:all
    @cp = []
    @carpark = []
    @carparks = []
    @mems.each do |mem|
      @p = mem.people
      i = 0
      @p.each do |p|
        i += 1
        @cp << p.last_name
        @cp << p.first_name
        @cp << p.email_address
        @cp << p.mobile_phone
        @cp << p.member.privilege.name
        @cp << p.member.renew_date.to_date
        @cp << p.member.id.to_s + Time.now.year.to_s.slice(2,2) + i.to_s
        @cp << p.salutation
        @cp << p.member.name_no
        @cp << p.member.street1
        @cp << p.member.street2
        @cp << p.member.town
        @cp << p.member.city
        @cp << p.member.postcode
        @cp << p.member.county
        @carparks << @cp
      end
    end
    @carpark = @carparks.sort
    report = CSV.generate do |csv|
      csv <<  ['Last Name', 'First Name', 'Email', 'Mobile', 'Mem Class', 'Renewed date',
        'Car Park No','Salutation','House Name/No', 'Address1','Address2', 'Town','City', 'Postcode','County']
      i = 0
      @carpark.each do |p|
        csv << [p[i + 0], p[i + 1], p[i + 2], p[i + 3], p[i + 4], p[i + 5], p[i + 6], p[i + 7],
          p[i + 8],p[i + 9],p[i + 10],p[i + 11],p[i + 12],p[i + 13],p[i + 14]   ]
        i = i + 15
      end
    end
    send_data(report,:type => 'text/csv; charset=iso-8859-1; header=present',
      :filename => 'CarParkPasses.csv', :disposition => 'attachment', :encoding => 'utf8')
  end


  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:proposed, :seconded, :year_joined, :renew_date,
	  :privilege_id, :name_no, :street1, :street2, :town, :city, :postcode, :county,
	  :country, :email_renewal,:active,
	  people_attributes: [:id,:first_name,:last_name,:status,:member_id,
	    :occupation, :dob, :home_phone, :mobile_phone, :email_address, :send_txt,
	    :send_email, :txt_cruising, :txt_cruiser_skipper, :txt_crace, :txt_cruiser_race_skipper,
	    :txt_dinghy_sailing, :txt_junior, :txt_op_co, :txt_social, :txt_bridge, :txt_test ] )
  end

end
