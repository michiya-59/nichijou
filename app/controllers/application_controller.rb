# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include(AdminSessionsHelper)
  before_action :authenticate_user, :redirect_not_logged_in

  # ログインされていない場合またはURLが直接操作されてた場合の処理
  def authenticate_user
    return if logged_in? && valid_referrer?

    reset_session
    flash[:logout] = "不正なアクセスがありました。<br>再度ログインをしてください。"
    redirect_to admin_login_path
  end

  # ログインされていない場合は、ログイン画面にリダイレクトさせる処理
  def redirect_not_logged_in
    return if current_admin

    reset_session
    flash[:logout] = "ログインされてません。ログインしてください。"
    redirect_to admin_login_path
  end

  # URLが直接操作されているかどうかの確認
  def valid_referrer?
    request.referer.present? && request.referer.include?(request.base_url)
  end
end
