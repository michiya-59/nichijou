# frozen_string_literal: true

class AddCouponTypeIdToCoupons < ActiveRecord::Migration[7.1]
  def change
    add_column :coupons, :coupon_type_id, :integer
  end
end
