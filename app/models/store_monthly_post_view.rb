# frozen_string_literal: true

class StoreMonthlyPostView < ApplicationRecord
  belongs_to :post
  belongs_to :store
end
