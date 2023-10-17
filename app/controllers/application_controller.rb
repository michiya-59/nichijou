# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include(AdminSessionsHelper)
  # before_action :authenticate_user, :redirect_not_logged_in, :redirect_not_session

  # ログインされていない場合またはURLが直接操作されてた場合の処理
  def authenticate_user
    return if logged_in? && valid_referrer?

    flash[:logout] = "不正なアクセスがありました。<br>再度ログインをしてください。"
    redirect_to admin_login_path
  end

  # ログインされていない場合は、ログイン画面にリダイレクトさせる処理
  def redirect_not_logged_in
    return if current_admin

    flash[:logout] = "ログインされてません。ログインしてください。"
    redirect_to admin_login_path
  end

    # 60分でセッションが切れて、ログアウトする処理
  def redirect_not_session
    return unless session[:expires_at]

    # session[:expires_at] を Time オブジェクトとして読み込み
    expires_at = Time.zone.parse(session[:expires_at].to_s)
    # 現在の時間との差を比較
    session_out_time = Time.zone.now - expires_at

    return unless session_out_time > 0

    reset_session
    flash[:logout] = "セッションが切れました<br>（60分間ご利用でない場合、または不正アクセスのため）"
    redirect_to admin_login_path
  end

  # URLが直接操作されているかどうかの確認
  def valid_referrer?
    request.referer.present? && request.referer.include?(request.base_url)
  end
end
