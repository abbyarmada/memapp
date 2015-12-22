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
        format.html { redirect_to person_path(@member.main_member), notice: 'Member was successfully created.' }
      else
        format.html { render action: 'new', notice: 'Member was not created - fix errors .' }
      end
    end
  end

  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to person_path(@member.main_member), notice: 'Member was successfully updated.' }
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
    require 'csv'
    @mems = Member.parking_members.includes(:people =>  [:member => :privilege] )
    @carpark = @mems
    report = CSV.generate do |csv|
      csv <<  ['Last Name', 'First Name', 'Email', 'Mobile', 'Mem Class', 'Renewed date',
        'Car Park No','Salutation','House Name/No', 'Address1','Address2', 'Town','City', 'Postcode','County','0']
      @mems.each do |mem|
        @people = mem.people
        i = 0
        @people = @people.sort_by{ |person| person.status}.reverse
        @people.each do |p|
          i += 1
          csv << [p.last_name,
            p.first_name,
            p.email_address,
            p.mobile_phone,
            p.member.privilege.name,
            p.member.renew_date.to_date,
            p.member.id.to_s + Time.now.year.to_s.slice(2,2) + i.to_s,
            p.salutation,
            p.member.name_no,
            p.member.street1,
            p.member.street2,
            p.member.town,
            p.member.city,
            p.member.postcode,
            p.member.county,
            p.status] if i <= 2
        end
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
