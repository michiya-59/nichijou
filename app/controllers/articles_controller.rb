# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :load_data, only: %i(index show)

  def index
    if params["type"] == "recommend"
      @articles = Post.with_attached_top_image.by_view_count.limit(30).includes(:top_image_blob)
      @title_en = "TOP PICKS"
      @title_ja = "おすすめ"
      @tag_name = "おすすめ記事"
    elsif params["type"] == "news"
      @articles = Post.with_attached_top_image.recent.limit(30).includes(:top_image_blob)
      @title_en = "News"
      @title_ja = "新着記事"
      @tag_name = "新着記事"
    end

    @categories = Rails.cache.fetch("categories", expires_in: 12.hours) do
      Category.all.to_a # オブジェクトをキャッシュする
    end
    @areas = Rails.cache.fetch("areas", expires_in: 12.hours) do
      Area.all.to_a # オブジェクトをキャッシュする
    end
  end

  def show; end

  private

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
