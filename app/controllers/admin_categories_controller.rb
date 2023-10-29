# frozen_string_literal: true

class AdminCategoriesController < ApplicationController
  before_action :set_category, only: %i(edit update destroy)

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "カテゴリーを追加しました"
      redirect_to admin_categories_path
    else
      flash[:error] = @category.errors.full_messages
      redirect_to new_admin_category_path
    end
  end

  def update
    if @category.update(category_params)
      flash[:success] = "カテゴリーを更新しました"
      redirect_to admin_categories_path
    else
      flash[:error] = @category.errors.full_messages
      redirect_to edit_admin_category_path
    end
  end

  def destroy
    @category.destroy
    flash[:destroy] = "カテゴリーを削除しました"
    redirect_to admin_categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
