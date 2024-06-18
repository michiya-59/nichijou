# frozen_string_literal: true

class AddPrefectureCodeToAreas < ActiveRecord::Migration[7.1]
  def change
    add_column :areas, :prefecture_code, :string
  end
end
