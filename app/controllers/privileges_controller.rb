class PrivilegesController < ApplicationController
  before_action :set_model, only: [:show, :edit, :update, :destroy]


  def index
    @privileges = Privilege.all
    respond_to do |format|
      format.html
    end
  end

  def show
  end

  def new
    @privilege = Privilege.new
  end

  def edit

  end
  def create
    @privilege = Privilege.new(privilege_params)
    respond_to do |format|
      if @privilege.save
        format.html { redirect_to privileges_path, notice: 'Member class was successfully created.' }
      else
        format.html { render action: 'new', notice: 'Member class was not created - fix errors .' }
      end
    end
  end
  def update
    respond_to do |format|
      if @privilege.update(privilege_params)
        format.html { redirect_to @privilege, notice: 'Member Class was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

   def destroy
     @privilege.destroy
     respond_to do |format| 
       format.html  { redirect_to privileges_path, notice: 'Member class was successfully deleted.' }
     end
   end

 private
  def set_model
    @privilege = Privilege.find(params[:id])
  end

  def privilege_params
    params.require(:privilege).
      permit(:member_class,:name,:bar_billies,:car_park,:votes,:bar_reference,:boat_storage)
  end

end
