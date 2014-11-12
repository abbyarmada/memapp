class PrivilegesController < ApplicationController

  def index
    @privileges = Privilege.all
    respond_to do |format|
      format.html
    end
  end

  def show
    @privilege = Privilege.find(params[:id])
  end

  def new
    @privilege = Privilege.new
  end

  def edit
    @privilege = Privilege.find(params[:id])
  end

  def create
    @privilege = Privilege.new(params[:privilege])
    respond_to do |format|
      if @privilege.save
        format.html { redirect_to privilege_path , notice: 'Member Class was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end


  def update
    @privilege = Privilege.find(params[:id])
    respond_to do |format|
      if @privilege.update_attributes(params[:privilege])
        format.html { redirect_to @privilege, notice: 'Member Class was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @privilege.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /privileges/1
  # DELETE /privileges/1.json
#  def destroy
#    @privilege = Privilege.find(params[:id])
#    @privilege.destroy###

#    respond_to do |format|
#      format.html { redirect_to privileges_url }
#      format.json { head :ok }
#    end
#  end
end
