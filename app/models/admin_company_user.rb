# frozen_string_literal: true

class AdminCompanyUser < ApplicationRecord
  has_secure_password
  belongs_to :store, optional: true
end
