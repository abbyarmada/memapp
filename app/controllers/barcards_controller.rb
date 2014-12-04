class BarcardsController < ApplicationController
   before_action :set_model, only: [:show, :edit, :update, :destroy]

  def show
    respond_with(@member)
  end
  def index
    @barcards = Barcard.all
    respond_with(@barcards)
  end
  def new
    @barcard = Barcard.new
    respond_with(@barcard)
  end

  def destroy
    @barcard.destroy
    respond_with(@barcard)
  end

  def edit
  end

  def update

    pid = params[:pid]
    mid = params[:mid]
    respond_to do |format|
      if @barcard.update(member_params)
        flash[:notice] = 'Barcard was successfully updated.'
        format.html {redirect_to :back }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def create
    pid = params[:pid]
    @barcard = Barcard.new(barcard_params)
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
        format.html {redirect_to  :controller => 'people', :action => 'edit', :id => pid }
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
