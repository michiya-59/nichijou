# frozen_string_literal: true

class HomesController < ApplicationController
  before_action :load_data, only: %i(index)

  def index
    @top_pick_articles = get_offset_number 6
    @news_articles = Post.with_attached_top_image.recent.limit(6)
    @notices = Notice.order(created_at: :asc).limit(5)
  end

  def about; end

  def pick_articles
    @top_pick_articles = get_offset_number 21
  end

  private

  def get_offset_number limit_number
    offset_number = Post.order(view_count: :asc).offset(5).limit(6).count < 5 ? 0 : 5
    Post.with_attached_top_image.order(view_count: :asc).offset(offset_number).limit(limit_number)
  end

  def load_data
    @ranking_articles = Post.with_attached_top_image.by_view_count.limit(5).includes(:top_image_blob)
    @categories = Rails.cache.fetch("categories", expires_in: 12.hours) do
      Category.all.to_a # オブジェクトをキャッシュする
    end
    @areas = Rails.cache.fetch("areas", expires_in: 12.hours) do
      Area.all.to_a # オブジェクトをキャッシュする
    end
  end
end
