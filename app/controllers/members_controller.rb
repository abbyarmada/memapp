class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @members = Member.all
    respond_with(@members)
  end

  def show
    respond_with(@member)
  end

  def new
    @member = Member.new
    respond_with(@member)
  end

  def edit
  end

  def create
    @member = Member.new(member_params)
    @member.save
    respond_with(@member)
  end

  def update
    @member.update(member_params)
    respond_with(@member)
  end

  def destroy
    @member.destroy
    respond_with(@member)
  end

  def carpark_passes
    process_carpark_passes
  end

  private
    def set_member
      @member = Member.find(params[:id])
    end

    def member_params
      params.require(:member).permit(:address1, :address2, :address3, :address4, :proposed, :seconded, :year_joined, :occupation, :renew_date, :privilege_id, :name_no, :street1, :street2, :town, :city, :postcode, :county, :country, :email_renewal)
    end

  def process_carpark_passes

    @mems = Member.current_members.parking_members #.all #:all
 
 
   
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
 
   if params[:commit] == 'Export CSV file'
      report = CSV.generate do |csv|
      csv <<  ['Last Name', 'First Name', 'Email', 'Mobile', 'Mem Class', 'Renewed date', 'Car Park No','Salutation','House Name/No', 'Address1','Address2', 'Town','City', 'Postcode','County']
      i = 0
      @carpark.each do |p|
         csv << [p[i + 0], p[i + 1], p[i + 2], p[i + 3], p[i + 4], p[i + 5], p[i + 6], p[i + 7],p[i + 8],p[i + 9],p[i + 10],p[i + 11],p[i + 12],p[i + 13],p[i + 14]   ]
        i = i + 15
      end
   end

 send_data(report,:type => 'text/csv; charset=iso-8859-1; header=present',:filename => 'CarParkPasses.csv', :disposition => 'attachment', :encoding => 'utf8')

  end
 end



end
