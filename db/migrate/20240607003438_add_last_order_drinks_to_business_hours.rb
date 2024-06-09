# frozen_string_literal: true

class AddLastOrderDrinksToBusinessHours < ActiveRecord::Migration[7.1]
  def change
    add_column :business_hours, :last_order_drink, :time
    add_column :business_hours, :last_order_drink2, :time
  end
end
