class SubscriptionsController < ApplicationController
 
  # GET /subscriptions
  # GET /subscriptions.xml
  def index
    @subscriptions = Subscription.find :all, :include => :privilege ,:order => "end_date desc" 
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @subscriptions }
    end
  end

  # GET /Subscriptions/new
  # GET /Subscriptions/new.xml
  def new
    @subscription = Subscription.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @@subscription }
    end
  end

  # GET /Subscriptions/1/edit
  def edit
    @subscription = Subscription.find(params[:id])
  end

  # POST /Subscriptions
  # POST /Subscriptions.xml
  def create
    @subscription = Subscription.new(params[:subscription])
    
    respond_to do |format|
      if @subscription.save
        flash[:notice] = 'Subscription was successfully created.'
        format.html { redirect_to(subscriptions_path) }
        format.xml  { render :xml => @subscription, :status => :created, :location => @subscription }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @subscription.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /Subscriptions/1
  # PUT /Subscriptions/1.xml
  def update
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      if @subscription.update_attributes(params[:subscription])
        flash[:notice] = 'Member Class was successfully updated.'
        format.html { redirect_to(subscriptions_path) }
     #   format.iphone { redirect_to(subscriptions_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
      #  format.iphone { render :action => "edit" }
        format.xml  { render :xml => @subscription.errors, :status => :unprocessable_entity }
      end
    end
   
  end

  # DELETE /Subscriptions/1
  # DELETE /Subscriptions/1.xml
  def destroy
   @subscription = Subscription.find(params[:id])

    respond_to do |format|
    
  if  @subscription.destroy
     flash[:notice] = 'Subscription was successfully deleted.'
        format.html { redirect_to(subscriptions_path) }
        format.xml  { head :ok }
      else
        format.html { redirect_to(subscriptions_path) }
        format.xml  { render :xml => @subscription.errors, :status => :unprocessable_entity }
   end
 end
 
 end
end
