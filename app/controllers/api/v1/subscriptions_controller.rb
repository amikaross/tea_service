class Api::V1::SubscriptionsController < ApplicationController 
  def create
    subscription = Subscription.new(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription)
    end
  end

  private

    def subscription_params
      params.require(:subscription).permit(:tea_id, :customer_id, :title, :frequency)
    end
end