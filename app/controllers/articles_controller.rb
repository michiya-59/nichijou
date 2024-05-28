# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :load_data, only: %i(index show multi_search)
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
    @article = Post.includes(:category, top_image_attachment: :blob).find(params[:id])
    # rubocop:disable Rails/SkipsModelValidations
    @article.increment!(:view_count)
    # rubocop:enable Rails/SkipsModelValidations
    @store = Store.find(@article.store_id)
    @coupons_list_1 = Coupon.where(store_id: @store.id).where(coupon_type_id: 1)
    @coupons_list_2 = Coupon.where(store_id: @store.id).where(coupon_type_id: 2)
    @related_articles = Post.where("category_id = ? OR area_id = ?", @article.category_id, @article.area_id).limit(4)
  end

  def authentication_approval
    # formから送信された認証コードを取得
    authentication_code = params[:authentication_code]
    # AdminCompanyUserモデルを使用して認証コードの検証を行う
    user = AdminCompanyUser.find_by(authentication_code:)

    respond_to do |format|
      if user
        reset_session
        # params[:id]で渡された投稿IDをセッションに保存して、後で使用できるようにする
        session[:post_id] = params[:id]
        session[:flash_message] = "認証に成功しました。ログインしてください。"
        # ここでログイン画面や次の遷移先にリダイレクトする
        format.js{render js: "window.location = '#{admin_login_path}';"}
      else
        # 認証が失敗した場合、JavaScriptを介してアラートを表示
        format.js{render js: "alert('認証に失敗しました。');"}
      end
    end
  end

  def multi_search
    @multi_search_articles = Post.all
    @prefecture_name = params[:prefecture]
    @city_name = params[:city]
    @category_name = params[:category]

    if @prefecture_name.present?
      area_ids = Area.where(name: @prefecture_name).pluck(:id)
      @multi_search_articles = @multi_search_articles.where(area_id: area_ids)
    end

    if @city_name.present?
      area_ids = Area.where(city_name: @city_name).pluck(:id)
      @multi_search_articles = @multi_search_articles.where(area_id: area_ids)
    end

    if @category_name.present?
      category_ids = Category.where(name: @category_name).pluck(:id)
      @multi_search_articles = @multi_search_articles.where(category_id: category_ids)
    end
    @multi_search_articles = @multi_search_articles.page(params[:page]).per(24)
  end

  private

  def search
    # 検索文字の受け取りと検証（不適切なパラメータがあれば除外）
    search_item = search_params[:search_item].strip

    if search_item.present?
      articles = Post.includes(:category, top_image_attachment: :blob).where("title LIKE :search OR content LIKE :search", search: "%#{search_item}%")
      @articles = articles.select(:id, :title, :created_at, :category_id).page(params[:page]).per(24)
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
    @ranking_articles = fetch_posts.includes(:category, top_image_attachment: :blob).by_view_count.select(:id, :title, :created_at, :view_count, :category_id).limit(5)
    @categories = Category.all
    @areas = Area.all
  end

  # 投稿を取得する共通の処理をメソッドに抽出
  def fetch_posts
    Post.includes(top_image_attachment: :blob)
  end

  # @articlesの設定を行うメソッド
  def set_articles
    type = params["type"]

    @articles = case type
                when "recommend"
                  fetch_posts.by_view_count.select(:id, :title, :created_at, :category_id).page(params[:page]).per(24)
                when "news"
                  fetch_posts.recent.select(:id, :title, :created_at, :category_id).page(params[:page]).per(24)
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
