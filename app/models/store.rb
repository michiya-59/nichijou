# frozen_string_literal: true

class Store < ApplicationRecord
  validates :name, presence: true
  validates :tel, presence: true
  validates :address, presence: true
end
