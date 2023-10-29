# frozen_string_literal: true

class AddCityNameToUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :admin_users, :city_name, :string if column_exists? :admin_users, :city_name
    remove_column :areas, :city_name, :string if column_exists? :areas, :city_name
    add_column :areas, :city_name, :string
  end
end
