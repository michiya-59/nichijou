# frozen_string_literal: true

class BusinessHour < ApplicationRecord
  belongs_to :store

  DAYS_OF_WEEK = %w(月 火 水 木 金 土 日 祝日).freeze

  # カスタムセッターを定義
  def day_of_week= value
    self[:day_of_week] = value.join("@")
  end
end
