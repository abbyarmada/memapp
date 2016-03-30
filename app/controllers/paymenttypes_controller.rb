class PaymenttypesController < ApplicationController
  before_action :set_model, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @paymenttypes = Paymenttype.all
    respond_with(@paymenttypes)
  end

  def show
    respond_with(@paymenttype)
  end

  def new
    @paymenttype = Paymenttype.new
  end

  def edit
  end

  def create
    @paymenttype = Paymenttype.new(paymenttype_params)
    flash[:notice] = 'Paymenttype was successfully created.' if @paymenttype.save
    respond_with(@paymenttype)
  end

  def update
    respond_to do |format|
      if @paymenttype.update(paymenttype_params)
        format.html { redirect_to @paymenttype, notice: 'Paymenttype was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
 end

  def destroy
    @paymenttype.destroy
    respond_with(@paymenttype)
  end

  private

  def set_model
    @paymenttype = Paymenttype.find(params[:id])
  end

  def paymenttype_params
    params.require(:paymenttype).permit(:name)
  end
end
