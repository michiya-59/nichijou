# frozen_string_literal: true

class CreateStoreMonthlyPostViews < ActiveRecord::Migration[7.1]
  def change
    create_table :store_monthly_post_views do |t|
      t.integer :view_counts, null: false, default: 0
      t.timestamp :view_month, null: false
      t.references :post, null: false, foreign_key: true
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end

    add_index :store_monthly_post_views, %i(post_id store_id view_month), unique: true, name: "index_store_monthly_post_views_on_post_store_month"
  end
end
