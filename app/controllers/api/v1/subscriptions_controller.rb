# frozen_string_literal: true

module Api
  module V1
    class SubscriptionsController < ApplicationController
      def index
        customer = Customer.find(params[:customer_id])
        render json: SubscriptionSerializer.new(customer.subscriptions)
      end

      def create
        subscription = Subscription.new(subscription_params)
        if subscription.save
          render json: SubscriptionSerializer.new(subscription), status: :created
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
  end
end
