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
        format.html { redirect_to @privilege, notice: 'Member class was successfully created.' }
        format.json { render action: 'show', status: :created, location: @privilege }
      else
        format.html { render action: 'new', notice: 'Member class was not created - fix errors .' }
        format.json { render json: @privilege.errors, status: :unprocessable_entity }
      end
    end
  end
  def update
    respond_to do |format|
      if @privilege.update(privilege_params)
        format.html { redirect_to @privilege, notice: 'Member Class was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @privilege.errors, status: :unprocessable_entity }
      end
    end
  end

 #def destroy
 #  @privilege.destroy
 #  respond_with(@privilege)
 #end

 private
  def set_model
    @privilege = Privilege.find(params[:id])
  end

  def privilege_params
    params.require(:privilege).
      permit(:member_class,:name,:bar_billies,:car_park,:votes,:bar_reference,:boat_storage)
  end

end
