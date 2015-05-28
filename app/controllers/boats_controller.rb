class BoatsController < ApplicationController
  before_action :set_model, only: [:show, :edit, :update, :destroy]
  respond_to :html
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

  end

  def create
    @boat = Boat.new(boat_params)
    respond_with(@boat, :location => person_path(@boat.owner) + '#tabs-5') do |format|
      if @boat.save
        flash[:notice] = 'Boat was successfully created.'
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @boat.update(boat_params)
    respond_with(@boat, :location => person_path(@boat.owner) + '#tabs-5') do |format|
      if @boat.save
        flash[:notice] = 'Boat was successfully updated.'
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    flash[:notice] = 'Boat was successfully deleted.' if @boat.destroy
     respond_with(@boat, :location => person_path(@boat.owner) + '#tabs-5')
  end

  def create_csv
    @boats = Boat.members_boats
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






 private

  def set_model
    @boat = Boat.find(params[:id])
  end

  def boat_params
    params.require(:boat).permit(:member_id,:boat_name,:boat_type,:boat_class,:sail_number,:pen_tag)
  end



end
