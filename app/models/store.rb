# frozen_string_literal: true

class Store < ApplicationRecord
  has_many :posts, dependent: :nullify
  has_many :admin_company_users, dependent: :destroy
  validates :name, presence: true
  validates :tel, presence: true
  validates :address, presence: true
end
