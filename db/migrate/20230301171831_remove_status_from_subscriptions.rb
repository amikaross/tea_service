# frozen_string_literal: true

class RemoveStatusFromSubscriptions < ActiveRecord::Migration[5.2]
  def change
    remove_column :subscriptions, :status, :string
  end
end
