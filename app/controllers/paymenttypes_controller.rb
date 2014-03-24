class PaymenttypesController < ApplicationController
  # GET /paymenttypes
  # GET /paymenttypes.xml
  def index
    @paymenttypes = Paymenttype.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @paymenttypes }
    end
  end

  # GET /paymenttypes/1
  # GET /paymenttypes/1.xml
  def show
    @paymenttype = Paymenttype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @paymenttype }
    end
  end

  # GET /paymenttypes/new
  # GET /paymenttypes/new.xml
  def new
    @paymenttype = Paymenttype.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @paymenttype }
    end
  end

  # GET /paymenttypes/1/edit
  def edit
    @paymenttype = Paymenttype.find(params[:id])
  end

  # POST /paymenttypes
  # POST /paymenttypes.xml
  def create
    @paymenttype = Paymenttype.new(params[:paymenttype])

    respond_to do |format|
      if @paymenttype.save
        flash[:notice] = 'Paymenttype was successfully created.'
        format.html { redirect_to(@paymenttype) }
        format.xml  { render :xml => @paymenttype, :status => :created, :location => @paymenttype }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @paymenttype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /paymenttypes/1
  # PUT /paymenttypes/1.xml
  def update
    @paymenttype = Paymenttype.find(params[:id])

    respond_to do |format|
      if @paymenttype.update_attributes(params[:paymenttype])
        flash[:notice] = 'Paymenttype was successfully updated.'
        format.html { redirect_to(@paymenttype) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @paymenttype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /paymenttypes/1
  # DELETE /paymenttypes/1.xml
  def destroy
    @paymenttype = Paymenttype.find(params[:id])
    @paymenttype.destroy

    respond_to do |format|
      format.html { redirect_to(paymenttypes_url) }
      format.xml  { head :ok }
    end
  end
end
