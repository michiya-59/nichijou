# frozen_string_literal: true

class AdminPostsController < ApplicationController
  before_action :set_post, only: %i(edit update destroy show)
  before_action :detail_set_post, only: %i(edit new)
  before_action :authenticate_user, :redirect_not_logged_in, :redirect_not_session, :set_session_expiration

  def index
    if current_company_admin?
      store_id = current_admin&.store_id
      @posts = Post.where(store_id:).order(created_at: :asc, updated_at: :asc)
    else
      @posts = Post.order(created_at: :asc, updated_at: :asc)
    end
  end

  def show; end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "投稿を追加しました"
      redirect_to admin_posts_path
    else
      flash[:error] = @post.errors.full_messages
      redirect_to new_admin_post_path
    end
  end

  def update
    if @post.update(post_params)
      flash[:success] = "投稿を更新しました"
      redirect_to admin_posts_path
    else
      flash[:error] = @post.errors.full_messages
      redirect_to edit_admin_post_path
    end
  end

  def destroy
    @post.destroy
    flash[:destroy] = "投稿を削除しました"
    redirect_to admin_posts_path, notice: "投稿を削除しました"
  end

  def upload_content_image
    image = params[:file]
    blob = ActiveStorage::Blob.create_and_upload!(io: image, filename: image.original_filename, content_type: image.content_type)

    render json: {url: url_for(blob)}
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :top_image, :category_id, :area_id, :store_id, :view_count)
  end

  def detail_set_post
    @categories = Category.all
    @areas = Area.order(name: :asc)
    if current_company_admin?
      store_id = current_admin&.store_id
      @stores = Store.where(id: store_id)
    else
      @stores = Store.all
    end
  end
end
