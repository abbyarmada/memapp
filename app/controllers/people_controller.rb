class PeopleController < ApplicationController

  require 'csv'
 before_action :check_search_form_reset, :only => [:index]
  before_action :set_model, only: [:show, :edit, :update, :destroy, :cut, :renewal_email]
  respond_to :html, :pdf

  def show
    @member = Member.find(@person.member_id) #required for membership form
    respond_to do |format|
      format.html
      format.pdf do
         pdf = PersonPdf.new(@person)
         send_data pdf.render, filename: "#{@person.last_name}_#{@person.first_name}.pdf",
                            type: "application/pdf",
                            disposition: "inline"
      end
    end
  end

  def create_renewals
     last_yr_start = (Time.now.year - 1).to_s + "-01-01"
     @renews = Person.find :all, :include => [:member],
     :conditions =>  "people.status = 'm' and ( members.renew_date  >= '#{last_yr_start}' or members.year_joined = Year(CURDATE())  ) AND privilege_id = 5"
     @renews.each do |person| @person = person
     #  respond_to do |format|
        # format.pdf
          pdf = PersonPdf.new(@person, view_context)
          send_data pdf.render, filename: "#{@person.last_name}_#{@person.first_name}.pdf",
                            type: "application/pdf"
       # end
       end
  end

  def index
    @people = Person.search(params)
    session[:search] = session[:jumpcurrent]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @person = Person.new(person_params)
    @person.member_id = person_params[:member_id]
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
        format.html { redirect_to :controller =>'people', :action => 'show',:id => @person.id   }
      else
        format.html { render :action => "new" }
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
        format.html { render :action => "edit" ,:id => @person.id }
        # redirect_to  person_path(Person.main_person(@member.id))  + '#tabs-2'
      end
    end
  end
  def destroy
    
    @main_member = Person.main_person(@person.member_id)
    if @person.status == 'm' 
      #redirect_to :back
      flash[:error] = 'Cannot delete the Main Member.'
      render :action => "show" ,:id => @person.id
    else
      @person.destroy
        flash[:notice] = 'Person Deleted.'
        render :action => "show" ,:id => @main_member.id
    end
  end
  def cut
     if @person.status == 'm'
        redirect_to :back
        flash[:notice] = 'Cannot Move the Main Member.'
    else
       session[:copypersonid] = @person.id
       session[:copypersonmid] = @person.member_id
       redirect_to :back
       flash[:notice] = 'Person Cut to memory, go to other membership and select paste.'
     end
  end
  def paste
    @person = Person.find(session[:copypersonid])
    @person.member_id  = params[:member_id]
    if @person.save
      session[:copypersonid] = ''
      redirect_to :back
      flash[:notice] = 'Person Moved to this membership'
    else
      flash[:notice] = 'An Error occured while moving this person to this membership'
    end
  end

 def renewal_email
     RenewalMailer.renewal_letter(@person).deliver
     redirect_to :back , :flash => { :success => "Renewal sent via Email" } 
  end

 def paid_up_extract_current
   date = (Time.now.year).to_s + "-01-01"
   filename = 'PaidupExtract.csv'
   type = 'Paidup'
   bar_interface2(date,filename,type)
 end

 def paid_up_extract_last_year
   date = (Time.now.year - 1 ).to_s + "-01-01"
   filename = 'PaidupExtractLastYear.csv'
   type = 'Paidup'
   bar_interface2(date,filename,type)
 end
 def paid_up_extract_two_year_ago
    date = (Time.now.year - 2 ).to_s + "-01-01"
   filename = 'PaidupExtractTwoYearsAgo.csv'
   type = 'Paidup'
   bar_interface2(date,filename,type)
 end

 def paid_up_extract_three_year_ago
    date = (Time.now.year - 3 ).to_s + "-01-01"
   filename = 'PaidupExtractThreeYearsAgo.csv'
   type = 'Paidup'
   bar_interface2(date,filename,type)
 end
 
 def paid_up_extract_four_year_ago
    date = (Time.now.year - 4 ).to_s + "-01-01"
   filename = 'PaidupExtractFourYearsAgo.csv'
   type = 'Paidup'
   bar_interface2(date,filename,type)
 end

def paid_up_extract_five_year_ago
    date = (Time.now.year - 5 ).to_s + "-01-01"
   filename = 'PaidupExtractFiveYearsAgo.csv'
   type = 'Paidup'
   bar_interface2(date,filename,type)
 end


 def bar_interface
   date = (Time.now.year - 1).to_s + "-01-01"
   filename = 'BarInterface.csv'
   type = 'Bar'
   bar_interface2(date,filename,type)
 end

  def bar_interface2(date,filename,type)

  if type == 'Bar'
      @people = Person.find :all,
                          :include =>[:member ,:peoplebarcard],
                          :conditions => " members.renew_date >= '#{date}'  ",
                          :order => "people.id,last_name,first_name"
  else
    enddate = date.slice(0,4) + "-12-31"
    @people = Person.find :all,
                          :include =>[:member ,:peoplebarcard,:payments],
                          :conditions => " payments.paymenttype_id in (1,4,5) and payments.date_lodged >= '#{date}' and payments.date_lodged <= '#{enddate}'  ",
                          :order => "people.id,last_name,first_name"
  end



    #if params[:commit] == 'Export CSV file' || 'Export CSV file2'
      extract = CSV.generate do |csv|
        # header row
      csv << ['BarBillies','MemClass','CardNo','LastName','FirstName','MemNumber',
      'Salutation','HouseNameNo','StreetAddr','StreetAddr2','Town','City','PostCode','County','Country',
      'RenewedCurrentYear','RenewedDate','dob','occupation',
      'HomePhone', 'Mobile','Email','Social','Racing','Cruiser','Dinghy','Junior','MembershipId','member_type'
      ]
      @people.each do |p|
          #privilege = Privilege.find_by_id p.member.privilege_id
          barreference = p.privilege.bar_reference if type == 'Bar'
          barreference = p.privilege.name if type == 'Paidup'
          salutation = ""
          renewedcurrentyear = ""
          #bar billies, based on member class  defaulted to N, set to Y if member class allows
          # and membership renewed. 
          # new members do not get bar billies.
          bar_billies = 'N'
          renewedcurrentyear  = 'N'
          if p.member.renew_date.year == Time.now.year 
            renewedcurrentyear  = 'Y'
            if p.status == "m" && p.member.renew_date < Privilege.billie_cutoff_date
              bar_billies = p.privilege.bar_billies
            end
          end
          occupation = ""
          if p.status == 'm' 
            occupation = p.member.occupation
          end
          social = "X" unless p.txt_social == 0
          racing = "X" unless p.txt_crace == 0
          cruising = "X" unless p.txt_cruising == 0
          dinghy = "X" unless p.txt_dinghy_sailing == 0
          junior = "X" unless p.txt_junior == 0
      	  barcard = ''
        barcd =  p.peoplebarcard.barcard_id || 0000  rescue nil

        barcard = (ENV['BARCARD_PREFIX'] + '%05d' % barcd).to_s if  p.peoplebarcard.barcard_id rescue nil
          if barreference != 0 and p.status != 'g'
            csv << [bar_billies,barreference, barcard ,p.last_name,p.first_name,p.id, 
            p.salutation,
            p.member.name_no,
            p.member.street1 ,
            p.member.street2 ,
            p.member.town ,
            p.member.city,
            p.member.postcode,
            p.member.county ,
            p.member.country,
            renewedcurrentyear,p.member.renew_date.to_date.to_s,p.dob,occupation,
            p.home_phone,p.mobile_phone,p.email_address,social,racing,cruising,dinghy,junior,p.member.id,p.status ]
          end
      end
     end #do csv
     send_data(extract,:type => 'text/csv; charset=iso-8859-1; header=present',:filename => filename, :disposition => 'attachment', :encoding => 'utf8')

    #end #if
  end #def

  def g_chart_mem_summ

#Start year is 2007
    years = Time.now.year - 2006 + 1
    @types = []

      years.times do |y|

      yr_start = (Time.now.year - y).to_s + "-01-01"
      yr_end = (Time.now.year - y).to_s + "-12-31"
      
      @types[y] = Payment.count  :all,
                              #:select => ' count(*)',
                             :joins => "inner join privileges ON privileges.id = payments.privilege_id", 
                            :conditions => "date_lodged >= '#{yr_start}' AND date_lodged <= '#{yr_end}' and member_class not in ('X','Y','E','R','H','T','L','V','A' )",  
                            :group => 'class_desc' ,:order => 'member_class ASC'
    
    end
  
  chart = []
  @chart = []
  color_code = ['0000ff','ff0000','008000','FFd700','A97838','5D7CBA']
  years.times do |y|
    
    chart[y] = GoogleChart::PieChart.new("400x200", "Membership Trends " + (Time.now.year - y).to_s, true)
    arr = @types[y].to_a
    @types[y].to_a.size.times do |x|
      chart[y].data arr[x][0], arr[x][1], color_code[x]
    end

  #chart[y].show_labels = true
  chart[y].show_legend = false
  @chart[y] = chart[y].to_url
  
   end
end


def paid_up_extract2
    
    
    this_yr_start = (Time.now.year ).to_s + "-01-01"
    
    #@people = Person.find :all, 
    #                    :include =>[:member,:privilege],
    #                    :joins => "inner join privileges ON privileges.id = members.privilege_id", 
    #                    :conditions => " ( members.renew_date >= '#{this_yr_start}' or ( members.renew_date = null and members.year_joined = #{Time.now.year} ) )and member_class not in ('X','Y','T','E')  "
    #
    @people = Person.find :all, 
                        :joins =>[:member ,:peoplebarcard,:privilege],
                        :conditions => "members.renew_date >= '#{this_yr_start}'  " #,
                        #:joins => "inner join privileges ON privileges.id = members.privilege_id",
                       # :order => "people.id,last_name,first_name"
                        
    if params[:commit] == 'Export CSV file'
       extract = CSV.generate do |csv|
        # header row
        csv << ['BarBillies','MemClass','MemberShipNo','CardNo','LastName','FirstName','MemNumber',
     'Salutation','HouseNameNo','StreetAddr','StreetAddr2','Town','City','PostCode','County','Country',
     'RenewedCurrentYear','RenewedDate','DoB','occupation',
     'HomePhone', 'Mobile','Email','Mem_type' ]
        @people.each do |p|
          privilege = Privilege.find_by_id p.member.privilege_id
          barreference = privilege.name
          occupation = ""
          renewedcurrentyear = ""
          housenameno = ""
          city = ""
          town =""
          postcode = ""
          county = ""
          country = ""
          #bar billies, based on member class  defaulted to N, set to Y if member class allows
          # and membership renewed. 
          # new members do not get bar billies.
          bar_billies = 'N'
          renewedcurrentyear  = 'N'
          if p.member.renew_date.year == Time.now.year 
            renewedcurrentyear  = 'Y'
            if p.status == "m" && p.member.renew_date < Privilege.billie_cutoff_date
              bar_billies = privilege.bar_billies
            end
          end
          occupation = p.member.occupation if p.status == 'm' 
          @cp = p.comm_prefs.upcase if p.comm_prefs
          social = "X" if /SO/.match(@cp)
          cruising = "X" if /CR/.match(@cp)
          racing = "X"  if /RA/.match(@cp)
          dinghy = "X" unless p.txt_dinghy_sailing == 0
          junior = "X" if /JU/.match(@cp)
          if p.status == "m" 
            csv << [bar_billies,barreference, p.member_id ,ENV['BARCARD_PREFIX'] + '%05d' % p.peoplebarcard.barcard_id.to_s ,p.last_name,p.first_name,p.id, 
            p.salutation,   
            p.member.name_no,
            p.member.street1 ,
            p.member.street2 ,
            p.member.town ,
            p.member.city,
            p.member.postcode,
            p.member.county ,
            p.member.country,
            renewedcurrentyear,p.member.renew_date.to_date.to_s,p.dob,occupation,
            p.home_phone,p.mobile_phone,p.email_address,p.status ]
          end
        end #do extract
        send_data(extract,:type => 'text/csv; charset=iso-8859-1; header=present',:filename => 'PaidUpMembers.csv', :disposition => 'attachment', :encoding => 'utf8')
      end
    end #if
  end #def

  def check_search_form_reset
    if params[:commit] == 'Reset'
       params[:search] = ""
       params[:searchfn] = ""
       params[:searchmp][:privilege_id] = ""
       params[:group] = false
       params[:past_members] = false
     end
  end

  def set_model
    @person = Person.find(params[:id])
  end

def person_params
      params.require(:person).
      permit(
        :member_id,
        :first_name,:last_name,:status,
        :home_phone,:mobile_phone,:email_address,
        :comm_prefs,:snd_txt,:snd_eml,
        :dob,
        :txt_bridge,:txt_social,:txt_crace,:txt_cruiser_race_skipper,:txt_cruising,
        :txt_cruiser_skipper,:txt_dinghy_sailing,:txt_junior,:txt_test,:txt_op_co,
        :occupation,
        :send_txt,:send_email
        )
   # params.require(:barcard).
   #   permit(:id)
  end


end #class
