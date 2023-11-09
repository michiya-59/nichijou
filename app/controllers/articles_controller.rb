# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :load_data, only: %i(index show)
  before_action :set_articles, only: [:index]
  before_action :set_titles_and_tags, only: [:index], if: ->{params["type"].present?}

  # ページネーションの設定
  def index
    if params.key?("search_item")
      search
    else
      set_articles
    end
  end

  def show
    @article = Post.find(params[:id])
    @article.increment!(:view_count)
  end

  private

  def search
    # 検索文字の受け取りと検証（不適切なパラメータがあれば除外）
    search_item = search_params[:search_item].strip

    if search_item.present?
      articles = Post.where("title LIKE :search OR content LIKE :search", search: "%#{search_item}%")
      @articles = articles.page(params[:page]).per(24)
      @title_en = search_item
      @title_ja = "による検索"
    else
      @articles = []
      @title_en = "Search"
      @title_ja = "検索結果なし"
    end
    @tag_name = "検索"
  rescue ActionController::ParameterMissing
    redirect_to(articles_path) and return
  end

  def search_params
    params.permit(:search_item)
  end

  # 共通データのロードを１つのメソッドに集約
  def load_data
    @ranking_articles = fetch_posts.with_attached_top_image.by_view_count.select(:id, :title, :created_at, :view_count, :category_id).limit(5)
      .with_attached_top_image.by_view_count.limit(5)
    @categories = Category.all
    @areas = Area.all
  end

  # 投稿を取得する共通の処理をメソッドに抽出
  def fetch_posts
    Post.includes(:top_image_blob)
  end

  # キャッシュされたデータを取得する共通の処理をメソッドに抽出
  def cached_data(name, &)
    Rails.cache.fetch(name, expires_in: 12.hours, &)
  end

  # @articlesの設定を行うメソッド
  def set_articles
    type = params["type"]

    @articles = case type
                when "recommend"
                  fetch_posts.with_attached_top_image.by_view_count.select(:id, :title, :created_at).page(params[:page]).per(24)
                when "news"
                  fetch_posts.with_attached_top_image.recent.select(:id, :title, :created_at).page(params[:page]).per(24)
                else
                  [] # typeが指定されていない場合は空の配列を返す
                end
  end

  # タイトルとタグの設定を行うメソッド
  def set_titles_and_tags
    type = params["type"]

    titles_and_tags = {
      "recommend" => ["TOP PICKS", "おすすめ", "おすすめ記事"],
      "news" => %w(News 新着記事 新着記事)
    }

    @title_en, @title_ja, @tag_name = titles_and_tags[type]
  end
end
