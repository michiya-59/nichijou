# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :load_data, only: %i(show)

  # ページネーションの設定
  def show
    @category = Category.where(id: params[:id]).select(:id, :name).first
    @articles = fetch_posts.with_attached_top_image
      .where(category_id: @category.id)
      .order(created_at: :asc)
      .page(params[:page]).per(24)
  end

  private

  # 共通データのロードを１つのメソッドに集約
  def load_data
    @ranking_articles = fetch_posts.with_attached_top_image.by_view_count.limit(5)
    @categories = cached_data("categories"){Category.all.to_a}
    @areas = cached_data("areas"){Area.all.to_a}
  end

  # 投稿を取得する共通の処理をメソッドに抽出
  def fetch_posts
    Post.includes(:top_image_blob)
  end

  # キャッシュされたデータを取得する共通の処理をメソッドに抽出
  def cached_data(name, &)
    Rails.cache.fetch(name, expires_in: 12.hours, &)
  end
end
