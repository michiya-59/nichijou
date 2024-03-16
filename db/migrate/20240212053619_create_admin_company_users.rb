# frozen_string_literal: true

class CreateAdminCompanyUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :admin_company_users do |t|
      t.string :login_id, null: false
      t.string :password_digest, null: false
      t.integer :status, null: false
      t.string :authentication_code, null: false
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
