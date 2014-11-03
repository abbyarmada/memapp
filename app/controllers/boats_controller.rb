class BoatsController < ApplicationController
  

  require 'csv'
  
  def index
     @boats = Boat.members_boats.paginate(:per_page => 30, :page => params[:page])  
     session[:listpath] = session[:jumpcurrent] unless nil?
  end


def create_csv
  
  @boats = Boat.members_boats
  
  if params[:commit] == 'Export CSV file'
    
    extract = CSV.generate do |csv|
    csv << [ 'Last Name', 'First Name', 'Boat Name', 'boat Type', 'boat class', 'Sail No.','Pen Tag','Home Phone', 'Mobile', 'Email','address','renewal', 'Member Class']
      @boats.each do |b|
         x = b.member.people.find_by_status('m')
         y = b.member
        csv << [x.last_name, x.first_name,b.boat_name, b.boat_type, b.boat_class, b.sail_number,b.pen_tag, x.home_phone, x.mobile_phone, x.email_address, y.address1, y.renew_date.to_date,y.privilege.name ]
      end 
    end
    send_data(extract,:type => 'text/csv; charset=iso-8859-1; header=present',:filename => 'boats.csv', :disposition => 'attachment', :encoding => 'utf8')
  end
end

  def new
    @boat = Boat.new
  end

  def edit
    @boat = Boat.find(params[:id])
  end

  def create
    @boat = Boat.new(params[:boat])
       pid = params[:pid]
    @boat.member_id = (params[:mid])
    respond_to do |format|
      if @boat.save
        flash[:notice] = 'Boat was successfully created.'
        format.html {redirect_to  :controller => 'people', :action => 'edit', :id => pid }
        format.xml  { render :xml => @boat, :status => :created, :location => @boat }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @boat.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @boat = Boat.find(params[:id])
    main_person = Person.main_person(@boat.member_id)
    respond_to do |format|
      if @boat.update_attributes(params[:boat])
        format.html { redirect_to edit_person_path(main_person) }
        flash[:notice] = 'Boat was successfully updated.'
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @boat = Boat.find(params[:id])
    @main_member = @boat.member.main_member
    @boat.destroy
    respond_to do |format|
      format.html   {redirect_to edit_person_path(@main_member) }
      format.xml  { head :ok }
    end
  end
end
