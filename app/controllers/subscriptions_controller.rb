class SubscriptionsController < ApplicationController

  def index
    @subscriptions = Subscription.find :all, :include => :privilege ,:order => "end_date desc"
    respond_to do |format|
      format.html
    end
  end

  def new
    @subscription = Subscription.new
    respond_to do |format|
      format.html
    end
  end

  def show
    @subscription = Subscription.find(params[:id])
  end

  def edit
    @subscription = Subscription.find(params[:id])
  end


  def create
    @subscription = Subscription.new(params[:subscription])
    respond_to do |format|
      if @subscription.save
        flash[:notice] = 'Subscription was successfully created.'
        format.html { redirect_to(subscriptions_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @subscription = Subscription.find(params[:id])
    respond_to do |format|
      if @subscription.update_attributes(params[:subscription])
        flash[:notice] = 'Member Class was successfully updated.'
        format.html { redirect_to(subscriptions_path) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    respond_to do |format|
      if  @subscription.destroy
        flash[:notice] = 'Subscription was successfully deleted.'
        format.html { redirect_to(subscriptions_path) }
      else
        format.html { redirect_to(subscriptions_path) }
      end
    end
  end

end
