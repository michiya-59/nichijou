# frozen_string_literal: true

class HomesController < ApplicationController
  before_action :load_data, only: %i(index)

  def index
    @top_pick_articles = get_offset_number 6
    @news_articles = Post.with_attached_top_image.recent.limit(6)
    @notices = Notice.order(created_at: :desc).limit(5)
  end

  def about; end

  def pick_articles
    @top_pick_articles = get_offset_number 21
  end

  private

  def get_offset_number limit_number
    # 5件目から始めて6件を取得する際に、5件未満の場合はオフセットを0にする
    offset_number = Post.order(view_count: :desc).offset(5).limit(6).count < 5 ? 0 : 5

    # view_countが0で同じ場合はランダムに並べる
    Post.with_attached_top_image
      .order(view_count: :desc)
      .order(Arel.sql("CASE WHEN view_count = 0 THEN RANDOM() END"))
      .offset(offset_number)
      .limit(limit_number)
  end

  def load_data
    @ranking_articles = Post.with_attached_top_image.by_view_count.limit(5).includes(:top_image_blob)
    @categories = Category.all
    @areas = Area.all
  end
end
