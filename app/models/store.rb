# frozen_string_literal: true

class Store < ApplicationRecord
  has_many :posts, dependent: :nullify
  validates :name, presence: true
  validates :tel, presence: true
  validates :address, presence: true
end
