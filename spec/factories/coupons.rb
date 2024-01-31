# frozen_string_literal: true

FactoryBot.define do
  factory :coupon do
    store_id{1}
    title{"MyString"}
    usage_terms{"MyString"}
    presentation_terms{"MyString"}
    bikou{"MyString"}
  end
end
