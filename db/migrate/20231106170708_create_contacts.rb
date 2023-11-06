# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.string :inquiry_type, null: false
      t.string :email, null: false
      t.string :name, null: false
      t.string :tel, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
