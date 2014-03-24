class MembersController < ApplicationController
  require 'csv'
  
  #auto_complete :member ,:proposed 
  #auto_complete :member ,:seconded
  #auto_complete :member, :proposed 
  #, :full => true
  
  #==============================================
  def index
      show
  end #
  
  #===============================================
  def show
        @members = Member.find :all
  end # show
  
  #===============================================
  
 
  def new
    @member  = Member.new
    @person = @member.people.build
    #@member.people.barcard.build
   # @person = Person.new
    @barcard = Barcard.new 
    @peoplebarcard = Peoplebarcard.new 
    @member.year_joined = Time.now.year.to_s
    @member.country = 'Ireland'
    
    #Set to Applicant
    @member.privilege = Privilege.find_by_name "Applicant"
  
  end # new
  
  def create
   # Member.transaction do 
    @member = Member.new(params[:member])
    @member.update_attributes!(params[:member])
    @member.update_attributes!(:renew_date => Time.now)
    @person = Person.new(params[:member][:person])
    @person.update_attributes!(:member_id => @member.id, :status => 'm')
    @barcard = Barcard.new(params[:barcard])
    @barcard.update_attributes!(params[:barcard])
     @peoplebarcard = Peoplebarcard.new(params[:peoplebarcard])
     @peoplebarcard.person_id = @person.id
     @peoplebarcard.barcard_id = @barcard.id
  # end 
  # if !@member.save or  !@person.save or  !@barcard.save or !@peoplebarcard.save
  #      raise ActiveRecord::Rollback
  # end
   #end
   
   
    respond_to do |format|
      if @member.save && @person.save 
        flash[:notice] = 'Member Successfully Created.'
        format.html { redirect_to edit_person_path(@person.id)  }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  
#   def update
#    @member = Member.find(params[:id])
#    #pid = params[:pid]
#    
#    if @member.save 
#        flash[:notice] = 'Member Successfully Updated.'
#        format.html { redirect_to :controller =>'people', :action => 'edit',:id => Person.main_member(params[:id])  }
#    end
    
   # respond_to do |format|
   #   if @member.update_attributes(params[:member])
   #     flash[:notice] = 'Member was successfully updated.'
   #     format.html { redirect_to :controller =>'people', :action => 'edit',:id => Person.main_person(@member.id)   }
   #   else
   #     format.html { redirect_to :controller =>'people', :action => 'edit',:id => Person.main_person(@member.id)}
   #   end
   # end
 #  end
  
  
  
  
  def update_renewed_from_payments
    
   
    @mems = Member.find :all ,:include => :people
    
    puts("here")
    @mems.each do |m|
      puts(m.id)
    #  puts(m.people.last_name)
      
      p = Payment.find :first ,:order => "date_lodged DESC", :conditions =>  "member_id = '#{m.id}' and paymenttype_id in (1,4)    "
      if p 
        m.renew_date = p.date_lodged.to_date rescue nil
        if !m.street1 
          if !m.address1 
            m.street1 = "unknown"
          else   
          m.street1 = m.address1
        end
        end
        t = m.save!
      end
      
      if t 
        flash[:notice] = 'Data was successfully updated.'

      else
        flash[:notice] = 'Problem updating data.'
      end
      
      
  end
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
  

  
 
end # class
