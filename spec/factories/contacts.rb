# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    inquiry_type{"MyString"}
    email{"MyString"}
    name{"MyString"}
    tel{"MyString"}
    content{"MyText"}
  end
end
