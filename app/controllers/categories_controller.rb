# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :load_data, only: %i(show)

  # ページネーションの設定
  def show
    @category = Category.where(id: params[:id]).select(:id, :name).first
    @category_name = if @category.present?
                       @category.name
                     else
                       "存在しないカテゴリー"
                     end
    @articles = fetch_posts
      .where(category_id: @category&.id)
      .order(created_at: :asc)
      .page(params[:page]).per(24)
  end

  private

  # 共通データのロードを１つのメソッドに集約
  def load_data
    @ranking_articles = fetch_posts.includes(:category).by_view_count.limit(5)
    @categories = Category.all
    @areas = Area.all
  end

  # 投稿を取得する共通の処理をメソッドに抽出
  def fetch_posts
    Post.includes(top_image_attachment: :blob)
  end
end
