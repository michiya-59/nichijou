# frozen_string_literal: true

class AdminSessionsController < ApplicationController
  skip_before_action :authenticate_user, :redirect_not_logged_in, only: %i(new create destroy)

  def new
    return unless current_admin

    redirect_to admin_posts_path
  end

  def create
    admin = AdminUser.find_by(login_id: params[:login_id])
    if admin&.authenticate(params[:password])
      login admin
      redirect_to admin_posts_path
    else
      flash[:alert] = "ログインIDまたはパスワードが間違っています"
      redirect_to admin_login_path
    end
  end

  def destroy
    session.delete(:admin_id)
    flash[:logout] = "ログアウトしました"
    redirect_to admin_login_path
  end
end
