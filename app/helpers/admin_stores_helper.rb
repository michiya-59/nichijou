# frozen_string_literal: true

module AdminStoresHelper
  def second_business_hourts? id
    business_hours = BusinessHour.where(store_id: id.to_i)
    business_hours.present?
  end
end
