# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :posts, dependent: :nullify
  validates :name, presence: true

  # 都道府県のユニークなリストを取得するメソッド
  def self.order_categoies
    Category.order(:id).pluck(:name)
  end
end
