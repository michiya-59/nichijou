# frozen_string_literal: true

class AdminSessionsController < ApplicationController
  def new
    return unless current_admin

    redirect_to admin_posts_path
  end

  def create
    admin = AdminUser.find_by(login_id: params[:login_id])
    admin = AdminCompanyUser.find_by(login_id: params[:login_id]) if admin.blank?

    unless admin&.authenticate(params[:password])
      session[:flash_message] = nil
      flash[:alert] = "ログインIDまたはパスワードが間違っています"
      redirect_to admin_login_path
      return # ここでアクションを終了
    end

    if session[:post_id].present?
      store_id = Post.find(session[:post_id].to_i).store_id
      if admin.store_id != store_id
        session[:flash_message] = nil
        flash[:logout] = "不正なアクセスです。<br>再度ログインをしてください。"
        redirect_to admin_login_path
        return # ここでアクションを終了
      end
    end

    login admin
    session[:flash_message] = nil
    redirect_to session[:post_id].present? ? edit_admin_post_path(session[:post_id].to_i) : admin_posts_path
  end

  def destroy
    reset_session
    flash[:logout] = "ログアウトしました"
    redirect_to admin_login_path
  end

  def create_users_from_spreadsheet; end
end
