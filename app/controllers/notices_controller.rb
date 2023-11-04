# frozen_string_literal: true

class NoticesController < ApplicationController
  def index
    @notices = Notice.order(created_at: :desc).page(params[:page]).per(15)

    @notices = @notices.where(kind: 1) if params[:type] == "notice"
    @notices = @notices.where(kind: 2) if params[:type] == "release"
  end
end
