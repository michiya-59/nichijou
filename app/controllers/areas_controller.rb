# frozen_string_literal: true

class AreasController < ApplicationController
  before_action :load_data, only: %i(show)

  # ページネーションの設定
  def show
    # 特定のIDでAreaを検索し、存在する場合はその名前を取得
    area = Area.select(:id, :name).find_by(id: params[:id])
    @area_name = area.name if area.present?

    # 取得した名前でAreaを検索し、関連するIDの配列を作成
    area_ids = Area.where(name: @area_name).pluck(:id)

    # Area IDが4または5のPost情報を取得
    @articles = Post.includes(top_image_attachment: :blob)
      .where(area_id: area_ids)
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

  # キャッシュされたデータを取得する共通の処理をメソッドに抽出
  def cached_data name, &
    Rails.cache.fetch(name, expires_in: 12.hours, &)
  end
end
