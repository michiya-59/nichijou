class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "カテゴリーを追加しました"
    else
      flash[:error] = @category.errors.full_messages
    end
    redirect_to categories_path
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:success] = "カテゴリーを更新しました"
    else
      flash[:error] = @category.errors.full_messages
    end
    redirect_to categories_path
  end

  def destroy
    @category.destroy
    flash[:destroy] = "カテゴリーを削除しました"
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
