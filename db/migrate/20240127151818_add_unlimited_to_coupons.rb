# frozen_string_literal: true

class AddUnlimitedToCoupons < ActiveRecord::Migration[7.1]
  def change
    add_column :coupons, :unlimited, :integer
  end
end
