# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates :title,
            :price,
            :status,
            :frequency,
            presence: true
end
