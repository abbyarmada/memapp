class SubscriptionsController < ApplicationController
  before_action :set_model, only: [:show, :edit, :update, :destroy]

  def index
    @subscriptions = Subscription.all
  end

  def new
    @subscription = Subscription.new
  end

  def show
  end

  def edit
  end


  def create
    @subscription = Subscription.new(subscription_params)
      if @subscription.save
        flash[:notice] = 'Subscription was successfully created.'
      end
     respond_with(@subscription)
  end


  def update
      if @subscription.update(subscription_params)
        flash[:notice] = 'Member Class was successfully updated.'
      end
   
  end

  def destroy

    respond_to do |format|
      if  @subscription.destroy
        flash[:notice] = 'Subscription was successfully deleted.'
        format.html { redirect_to(subscriptions_path) }
        format.js
      else
        format.html { redirect_to(subscriptions_path) }
        format.js
      end
    end
  end
  
  private
  def set_model
    @subscription = Subscription.find(params[:id])
  end

  def subscription_params
    params.require(:subscription).
      permit(:amount,:start_date,:end_date,:privilege_id)
  end

end
