class AreasController < ApplicationController
  before_action :set_area, only: [:edit, :update, :destroy]

  def index
    @areas = Area.all
  end

  def new
    @area = Area.new
  end

  def create
    @area = Area.new(area_params)
    if @area.save
      flash[:success] = "エリアを追加しました"
    else
      flash[:error] = @area.errors.full_messages
    end
    redirect_to areas_path
  end

  def edit
  end

  def update
    if @area.update(area_params)
      flash[:success] = "エリアを更新しました"
    else
      flash[:error] = @area.errors.full_messages
    end
    redirect_to areas_path
  end

  def destroy
    @area.destroy
    flash[:destroy] = "エリアを削除しました"
    redirect_to areas_path, notice: 'エリアを削除しました'
  end

  private

  def set_area
    @area = Area.find(params[:id])
  end

  def area_params
    params.require(:area).permit(:name)
  end
end
