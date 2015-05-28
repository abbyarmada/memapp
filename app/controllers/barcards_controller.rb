class BarcardsController < ApplicationController
   before_action :set_model, only: [:show, :edit, :update, :destroy]
   respond_to :html

  def show
    @barcards = Barcard.all
  end
  def index
    show
  end

  def new
    @barcard = Barcard.new
    @peoplebarcard = Peoplebarcard.new
    respond_to do |format|
     format.html  # new.html.erb
   end
  end

  def destroy
    @barcard.destroy
  end

  def edit
  end

  def update

    pid = params[:pid]
    mid = params[:mid]
    respond_to do |format|
      if @barcard.update(barcard_params)
        flash[:notice] = 'Barcard was successfully updated.'
        format.html {redirect_to :back }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def create
    pid = params[:pid]
    @barcard = Barcard.new
    @peoplebarcard = Peoplebarcard.new(params[:peoplebarcard])
    # find the current personbarcard
    @currentbc = Peoplebarcard.find_by_person_id pid
    respond_to do |format|
      if @barcard.save
        @peoplebarcard.person_id = pid
        @peoplebarcard.barcard_id = @barcard.id
        @peoplebarcard.save
        if @currentbc
          @currentbc.destroy
        end
        flash[:notice] = 'Barcard was successfully created.'
        format.html { redirect_to person_path( :id =>   @peoplebarcard.person_id ) + '#tabs-6' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  private

  def set_model
    @barcard = Barcard.find(params[:id])
  end

  def barcard_params
    params.require(:barcard)
  end

end
