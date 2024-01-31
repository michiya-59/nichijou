# frozen_string_literal: true

class CreateCoupons < ActiveRecord::Migration[7.1]
  def change
    create_table :coupons do |t|
      t.references :store, null: false, foreign_key: true
      t.string :title
      t.string :usage_terms
      t.string :presentation_terms
      t.string :bikou

      t.timestamps
    end
  end
end
