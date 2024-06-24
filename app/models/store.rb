# frozen_string_literal: true

class Store < ApplicationRecord
  has_many :posts, dependent: :nullify
  has_many :admin_company_users, dependent: :destroy
  has_many :store_monthly_post_views, dependent: :destroy
  has_many :business_hours, dependent: :destroy
  accepts_nested_attributes_for :business_hours, allow_destroy: true

  validates :name, presence: true
  validates :tel, presence: true
  validates :address, presence: true
end
