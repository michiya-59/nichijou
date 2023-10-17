class AdminUser < ApplicationRecord
  has_secure_password

  validates :login_id, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }

end
