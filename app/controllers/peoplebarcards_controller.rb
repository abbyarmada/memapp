class PeoplebarcardsController < ApplicationController

  before_action :set_model, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def show
    @barcards = Peoplebarcard.all
  end

 def index
   show
 end
  def list
    show
 end

   def new
    @peoplebarcard = Peoplebarcard.new(peoplebarcard_params)
    respond_to do |format|
      format.html  # new.html.erb
    end
  end

  def delete
    destroy
  end

  def destroy
    @pid = params[:pid]
    @peoplebarcard.destroy
  end

  def edit
    @peoplebarcard = Peoplebarcard.find(params[:id])
  end

  def update
    pid = params[:pid]
    mid = params[:mid]
    respond_to do |format|
      if @peoplebarcard.update(peoplebarcard_params)
        flash[:notice] = 'Barcard was successfully updated.'
        format.html { redirect_to person_path + '#tabs-6' }
      else
        format.html { render :action => "edit" }
      end
    end

 end


 def create
    @peoplebarcard = Peoplebarcard.new(params[:barcard])
    respond_to do |format|
      if @barcard.save
        flash[:notice] = 'Barcard was successfully created.'
        format.html {redirect_to person_path + '#tabs-6'  }
      else
        format.html { render :action => "new" }
      end
    end
  end


def expired
     @expiredmems = Member.expired_members
end


private

def peoplebarcard_params
  params.require(:peoplebarcard).permit(:person_id,:barcard_id)
end

def set_model
  @peoplebarcard = Peoplebarcard.find(params[:id])
end

end
