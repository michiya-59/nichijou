# frozen_string_literal: true

class ChangeTelNullConstraintInStores < ActiveRecord::Migration[7.1]
  def change
    change_column_null :stores, :tel, true
  end
end
