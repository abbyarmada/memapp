class MembersController < ApplicationController
  require 'csv'
  
 
  def index
      @members = Member.find :all #, :include => :privilege ,:order => ""
    respond_to do |format|
      format.html
    end
  end #
  
  
  def show
    @member = Member.find(params[:id])
  end # show
  
 
  
 
  def new
    @member  = Member.new
    #@member.people.build

    @member.year_joined = Time.now.year.to_s
    @member.renew_date = Time.now
    @member.country = 'Ireland'
    #@member.people[0].member_id = params[:id]
    #@member.people[0].status  = 'm'
    #Set to Applicant
    @member.privilege = Privilege.find_by_name "Applicant"
  
  end # new
  
  def create
   # Member.transaction do 
    @member = Member.new(params[:member])
    #@person = Person.new(params[:person])
   # @person = @member.people.build(person_params)
   # @person.status = 'm'
     

    #@member.people[0].member_id = params[:id]
    #@person.member_id = @member.id 
    @member.update_attributes(:renew_date => Time.now)
    if @member.save 
      #@person.member_id = @member.id 
      #@person.save 
     # @barcard = Barcard.new(params[:barcard])
    #  @barcard.update_attributes(params[:barcard])
     # @peoplebarcard = Peoplebarcard.new(params[:peoplebarcard])
    #  @peoplebarcard.person_id = @person.id 
    #  @peoplebarcard.barcard_id = @barcard.id 
   #   @peoplebarcard.save
    end 
     respond_to do |format|
       if @member.save  #&& @barcard.save && @peoplebarcard.save
         flash[:notice] = 'Member Successfully Created.'
         format.html { redirect_to member_path(@member)  }
       else
         flash[:warn] = "Please correct the #{ helpers.pluralize(@member.errors.count  ,"error")  } hilighted below" 
         format.html { render :action => "new" }
       end
    end
  end
 
  def update
     @member = Member.find(params[:id])
     respond_to do |format | 
       if @member.update_attributes(params[:member])
         flash[:notice] = "Successfully updated Member."
         format.html { redirect_to(members_path) }
         # redirect_to  person_path(Person.main_person(@member.id))  + '#tabs-2'
       else
         #flash[:error] = "Member cannot be saved"
         #redirect_to  person_path(Person.main_person(@member.id)) + '#tabs-2' 
         format.html { render :action => "edit" }
       end
     end 
  end
  
  def edit 
     @member = Member.find(params[:id])
    # redirect_to person_path(Person.main_person(@member.id))  + '#tabs-2' 
  end
  
  
 
  
 def carpark_passes

   
   @mems = Member.current_and_internal_members.parking_members.all #:all
 
 
   
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
     # 
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
  
  def helpers
    ActionController::Base.helpers
  end
  
  

  private

  



 
end # class
