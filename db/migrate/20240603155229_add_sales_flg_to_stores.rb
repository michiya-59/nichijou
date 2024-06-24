# frozen_string_literal: true

class AddSalesFlgToStores < ActiveRecord::Migration[7.1]
  def change
    add_column :stores, :sales_flg, :integer, default: 1, null: false
  end
end
