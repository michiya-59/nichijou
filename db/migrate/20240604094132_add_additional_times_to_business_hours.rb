# frozen_string_literal: true

class AddAdditionalTimesToBusinessHours < ActiveRecord::Migration[7.1]
  def change
    add_column :business_hours, :opening_time2, :time
    add_column :business_hours, :closing_time2, :time
    add_column :business_hours, :opening_time3, :time
    add_column :business_hours, :closing_time3, :time
  end
end
