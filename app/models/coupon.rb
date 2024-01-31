# frozen_string_literal: true

class Coupon < ApplicationRecord
  belongs_to :store
  validate :expiration_date_or_unlimited_present

  private

  # expiration_dateとunlimitedの少なくとも一方が存在することを確認
  def expiration_date_or_unlimited_present
    return unless expiration_date.blank? && (unlimited.blank? || unlimited == false)

    errors.add(:base, "有効期限または無期限のいずれかを設定してください。")
  end
end
