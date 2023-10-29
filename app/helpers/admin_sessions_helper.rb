# frozen_string_literal: true

module AdminSessionsHelper
  def login admin
    session[:admin_id] = admin.id
  end

  def current_admin
    return unless (admin_id = session[:admin_id])

    @current_admin ||= AdminUser.find_by(id: admin_id)
  end

  def logout
    current_admin
    reset_session
    @current_admin = nil
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_admin.nil?
  end
end
