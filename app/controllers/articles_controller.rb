class ArticlesController < ApplicationController
  before_action :load_data, only: %i(index show)
  before_action :set_articles, only: [:index]
  before_action :set_titles_and_tags, only: [:index], if: -> { params["type"].present? }

  # ページネーションの設定
  def index
    @articles = Kaminari.paginate_array(@articles).page(params[:page]).per(24)
  end

  def show; end

  private

  # 共通データのロードを１つのメソッドに集約
  def load_data
    @ranking_articles = fetch_posts.with_attached_top_image.by_view_count.limit(5)
    @categories = cached_data('categories') { Category.all.to_a }
    @areas = cached_data('areas') { Area.all.to_a }
  end

  # 投稿を取得する共通の処理をメソッドに抽出
  def fetch_posts
    Post.includes(:top_image_blob)
  end

  # キャッシュされたデータを取得する共通の処理をメソッドに抽出
  def cached_data(name)
    Rails.cache.fetch(name, expires_in: 12.hours) do
      yield
    end
  end

  # @articlesの設定を行うメソッド
  def set_articles
    type = params["type"]
    limit = 24

    @articles = case type
                when "recommend"
                  fetch_posts.with_attached_top_image.by_view_count.limit(limit)
                when "news"
                  fetch_posts.with_attached_top_image.recent.limit(limit)
                else
                  [] # typeが指定されていない場合は空の配列を返す
                end
  end

  # タイトルとタグの設定を行うメソッド
  def set_titles_and_tags
    type = params["type"]
    
    titles_and_tags = {
      "recommend" => ["TOP PICKS", "おすすめ", "おすすめ記事"],
      "news" => ["News", "新着記事", "新着記事"]
    }
    
    @title_en, @title_ja, @tag_name = titles_and_tags[type]
  end
end
