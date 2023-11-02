# frozen_string_literal: true

class AdminAreasController < ApplicationController
  before_action :set_area, only: %i(edit update destroy)
  before_action :authenticate_user, :redirect_not_logged_in

  def index
    @areas = Area.all
  end

  def new
    @area = Area.new
  end

  def edit; end

  def create
    @area = Area.new(area_params)
    if @area.save
      flash[:success] = "エリアを追加しました"
    else
      flash[:error] = @area.errors.full_messages
    end
    redirect_to admin_areas_path
  end

  def update
    if @area.update(area_params)
      flash[:success] = "エリアを更新しました"
    else
      flash[:error] = @area.errors.full_messages
    end
    redirect_to admin_areas_path
  end

  def destroy
    @area.destroy
    flash[:destroy] = "エリアを削除しました"
    redirect_to admin_areas_path, notice: "エリアを削除しました"
  end

  private

  def set_area
    @area = Area.find(params[:id])
  end

  def area_params
    params.require(:area).permit(:name, :city_name)
  end
end
