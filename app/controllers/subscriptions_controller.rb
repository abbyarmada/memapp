class SubscriptionsController < ApplicationController
  before_action :set_model, only: [:show, :edit, :update, :destroy]

  def index
    @subscriptions = Subscription.all.includes(:privilege)
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
    respond_to do |format|
      if @subscription.save
        format.html { redirect_to @subscription, notice: 'Subscription was successfully created.' }
        format.json { render action: 'show', status: :created, location: @subscription }
      else
        format.html { render action: 'new', notice: 'Subscription was not created - fix errors .' }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html {  redirect_to @subscription, notice: 'Subscription was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to subscriptions_url , notice: 'Subscription was successfully deleted.'}
      format.json { head :no_content }
    end
  end

  private
  def set_model
    @subscription = Subscription.find(params[:id])
  end

  def subscription_params
    params.require(:subscription).permit(:amount,:start_date,:end_date,:privilege_id)
  end

end
