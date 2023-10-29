# frozen_string_literal: true

class AdminNoticesController < ApplicationController
  before_action :set_notice, only: %i(edit update destroy)

  def index
    @notices = Notice.all
  end

  def new
    @notice = Notice.new
  end

  def edit; end

  def create
    @notice = Notice.new(notice_params)
    if @notice.save
      flash[:success] = "エリアを追加しました"
    else
      flash[:error] = @notice.errors.full_messages
    end
    redirect_to admin_notices_path
  end

  def update
    if @notice.update(notice_params)
      flash[:success] = "エリアを更新しました"
    else
      flash[:error] = @notice.errors.full_messages
    end
    redirect_to admin_notices_path
  end

  def destroy
    @notice.destroy
    flash[:destroy] = "エリアを削除しました"
    redirect_to admin_notices_path, notice: "エリアを削除しました"
  end

  private

  def set_notice
    @notice = Notice.find(params[:id])
  end

  def notice_params
    params.require(:notice).permit(:title, :kind, :content)
  end
end
