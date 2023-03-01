# frozen_string_literal: true

class Customer < ApplicationRecord
  has_many :subscriptions
  validates :first_name,
            :last_name,
            :email,
            :address,
            presence: true
end
