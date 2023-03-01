class Api::V1::SubscriptionsController < ApplicationController 
  def create
    subscription = Subscription.new(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription)
    else
      render json: ErrorSerializer.missing_attributes(subscription.errors.full_messages), status: :bad_request
    end
  end

  def update
    subscription = Subscription.find(params[:id])
    subscription.update(subscription_params)
    render json: SubscriptionSerializer.new(subscription)
  end

  private

    def subscription_params
      params.require(:subscription).permit(:tea_id, :customer_id, :title, :frequency, :price, :status)
    end
end