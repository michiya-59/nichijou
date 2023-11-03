# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :category
  belongs_to :area
  belongs_to :store
  has_one_attached :top_image

  validates :title, presence: true, length: {maximum: 256}
  validates :top_image, presence: true
  validates :content, presence: true
  validates :view_count, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validate :acceptable_image

  scope :by_view_count, ->{order(view_count: :desc)}
  scope :recent, ->{order(created_at: :desc)}

  def acceptable_image
    return unless top_image.attached?

    errors.add(:top_image, "は1MB以下の画像をアップロードしてください") unless top_image.byte_size <= 3.megabyte

    acceptable_types = ["image/jpeg", "image/png", "image/jpg"]
    return if acceptable_types.include?(top_image.content_type)

    errors.add(:top_image, "はJPEGまたはPNG形式でアップロードしてください")
  end
end
