# frozen_string_literal: true

class HomesController < ApplicationController
  before_action :load_data, only: %i(index)

  def index
    @top_pick_articles = get_offset_number(6)
    @news_articles = Post.with_attached_top_image.recent.limit(6)
    @notices = Notice.order(created_at: :desc).limit(5)
  end

  def about; end

  def pick_articles
    @top_pick_articles = get_offset_number(21)
  end

  private

  def get_offset_number limit_number
    offset_number = Post.order(view_count: :desc).offset(5).limit(6).count < 5 ? 0 : 5
    Post.with_attached_top_image.order(view_count: :desc).offset(offset_number).limit(limit_number)
  end

  def load_data
    @ranking_articles = Post.with_attached_top_image.includes(:category).by_view_count.limit(5)
    @categories = Category.all
    @areas = Area.all
  end
end
