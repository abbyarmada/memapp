class BarcardsController < ApplicationController
  before_action :set_model, only: [:edit, :update, :destroy]
  respond_to :html

  def new
    @barcard = Barcard.new
    @peoplebarcard = Peoplebarcard.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def destroy
    @barcard.destroy
  end

  def edit
  end

  def update
    respond_to do |format|
      if @barcard.update(barcard_params)
        flash[:notice] = 'Barcard was successfully updated.'
        format.html { redirect_to :back }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def create
    @barcard = Barcard.new
    @peoplebarcard = Peoplebarcard.new(params[:peoplebarcard])
    # find the current personbarcard
    @currentbc = Peoplebarcard.find_by_person_id pid

    flash[:notice] = 'Barcard was successfully updated.'
    respond_to do |format|
      if @barcard.save
        @peoplebarcard.person_id = pid
        @peoplebarcard.barcard_id = @barcard.id
        @peoplebarcard.save
        @currentbc.destroy if @currentbc
        flash[:notice] = 'Barcard was successfully created.'
        format.html { redirect_to person_path(id: @peoplebarcard.person_id) + '#tabs-6' }
      else
        format.html { render action: 'new' }
        flash[:notice] = 'Barcard was not created.'
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
