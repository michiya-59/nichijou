# frozen_string_literal: true

class AddLastOrderTimeToBusinessHours < ActiveRecord::Migration[7.1]
  def change
    add_column :business_hours, :last_order_time, :time
    add_column :business_hours, :last_order_time2, :time
  end
end
