class HomesController < ApplicationController  
  def index
    offset_number = Post.order(view_count: :desc).offset(5).limit(6).count < 5 ? 0 : 5
    @top_pick_articles = Post.with_attached_top_image.order(view_count: :desc).offset(offset_number).limit(6)
    @ranking_articles = Post.with_attached_top_image.by_view_count.limit(5)
    @news_articles = Post.with_attached_top_image.recent.limit(6) 
    @notices = Notice.order(created_at: :desc).limit(5)
    @categories = Category.all
    @areas = Area.all
  end

  def about

  end
end
