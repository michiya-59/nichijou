# frozen_string_literal: true

class AddGoogleMapUrlToStores < ActiveRecord::Migration[7.1]
  def change
    add_column :stores, :google_map_url, :string
  end
end
