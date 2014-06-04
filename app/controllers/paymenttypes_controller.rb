class PaymenttypesController < ApplicationController
  def index
    @paymenttypes = Paymenttype.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  def show
    @paymenttype = Paymenttype.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end
  def new
    @paymenttype = Paymenttype.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end
  def edit
    @paymenttype = Paymenttype.find(params[:id])
  end
  def create
    @paymenttype = Paymenttype.new(params[:paymenttype])
    respond_to do |format|
      if @paymenttype.save
        flash[:notice] = 'Paymenttype was successfully created.'
        format.html { redirect_to(@paymenttype) }
      else
        format.html { render :action => "new" }
      end
    end
  end
  def update
    @paymenttype = Paymenttype.find(params[:id])
    respond_to do |format|
      if @paymenttype.update_attributes(params[:paymenttype])
        flash[:notice] = 'Paymenttype was successfully updated.'
        format.html { redirect_to(@paymenttype) }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  def destroy
    @paymenttype = Paymenttype.find(params[:id])
    @paymenttype.destroy
    respond_to do |format|
      format.html { redirect_to(paymenttypes_url) }
    end
  end
end
