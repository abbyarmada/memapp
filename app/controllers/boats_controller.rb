class BoatsController < ApplicationController
  require 'csv'

  def index
     @boats = Boat.members_boats.paginate(:per_page => 30, :page => params[:page])
     session[:listpath] = session[:jumpcurrent] unless nil?
  end

  def new
    @boat = Boat.new
    @boat.member_id = params[:member_id]
  end

  def edit
    @boat = Boat.find(params[:id])
  end

  def create
    @boat = Boat.new(params[:boat])
    @boat.member_id = params[:member_id]
    respond_to do |format|
      if @boat.save
        flash[:notice] = 'Boat was successfully created.'
          format.html { redirect_to person_path(@boat.owner) + '#tabs-5' }
      else
        format.html { render :action => "new" }
        flash[:error] = 'Boat was not successfully created.'
      end
    end
  end
  def update
    @boat = Boat.find(params[:id])
    respond_to do |format|
      if @boat.update_attributes(params[:boat])
        format.html { redirect_to person_path(@boat.owner)  + '#tabs-5' }
        flash[:notice] = 'Boat was successfully updated.'
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @boat = Boat.find(params[:id])
    @boat.destroy
    respond_to do |format|
     format.html { redirect_to person_path(@boat.owner)  + '#tabs-5' }
    end
  end

  def create_csv
    @boats = Boat.members_boats
    if params[:commit] == 'Export CSV file'
      extract = CSV.generate do |csv|
        csv << [ 'Last Name', 'First Name', 'Boat Name', 'boat Type', 'boat class', 'Sail No.','Pen Tag','Home Phone', 'Mobile', 'Email','address','renewal', 'Member Class']
        @boats.each do |b|
          x = b.owner
          y = b.member
          csv << [x.last_name, x.first_name,b.boat_name, b.boat_type, b.boat_class, b.sail_number,b.pen_tag, x.home_phone, x.mobile_phone, x.email_address, y.address1, y.renew_date.to_date,y.privilege.name ]
        end
      end
    send_data(extract,:type => 'text/csv; charset=iso-8859-1; header=present',:filename => 'boats.csv', :disposition => 'attachment', :encoding => 'utf8')
    end
  end

end
