# frozen_string_literal: true

FactoryBot.define do
  factory :store_monthly_post_view do
    view_counts{1}
    view_month{"2024-06-17 23:57:21"}
    post{nil}
    store{nil}
  end
end
