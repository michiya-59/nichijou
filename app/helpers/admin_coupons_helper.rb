# frozen_string_literal: true

module AdminCouponsHelper
  def get_coupon_type_name coupon_type_id
    case coupon_type_id
    when 1
      "初回来店用クーポン"
    when 2
      "2回目来店用クーポン"
    end
  end
end
