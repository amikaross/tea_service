# frozen_string_literal: true

class SubscriptionSerializer
  include JSONAPI::Serializer

  attributes :customer_id, :tea_id, :title, :frequency, :status, :price
end
