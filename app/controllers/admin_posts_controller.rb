# frozen_string_literal: true

class AdminPostsController < ApplicationController
  before_action :set_post, only: %i(edit update destroy show)
  before_action :detail_set_post, only: %i(edit new)
  before_action :authenticate_user, :redirect_not_logged_in, :redirect_not_session, :set_session_expiration

  def index
    if current_company_admin?
      store_id = current_admin&.store_id
      @posts = Post.includes(:store).where(store_id:).order(created_at: :asc, updated_at: :asc)
    else
      @posts = Post.includes(:store).order(created_at: :desc, updated_at: :desc)
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

  def view_counts
    @post = Post.find(params[:id])
    view_counts_data = StoreMonthlyPostView.where(post_id: params[:id])
      .group("DATE_TRUNC('month', view_month)")
      .sum(:view_counts)
      .transform_keys{|date| date.strftime("%Y-%m")}

    # 1月から12月までの全ての月を含むハッシュを作成
    current_year = Time.zone.now.year
    all_months = (1..12).map{|month| Date.new(current_year, month, 1).strftime("%Y-%m")}

    @all_view_counts = all_months.index_with do |year_month|
      view_counts_data[year_month] || 0
    end

    current_year_month = Time.zone.now.strftime("%Y-%m")
    @all_view_counts[current_year_month] += @post&.view_count.to_i
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
