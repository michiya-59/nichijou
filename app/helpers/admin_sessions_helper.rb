# frozen_string_literal: true

module AdminSessionsHelper
  def login admin
    session[:admin_id] = admin.id
  end

  def current_admin
    return unless (admin_id = session[:admin_id])

    tmp_current_admin = AdminUser.find_by(id: admin_id)
    tmp_current_admin = AdminCompanyUser.find_by(id: admin_id) if tmp_current_admin.blank?
    @current_admin ||= tmp_current_admin
  end

  def current_company_admin?
    current_admin.instance_of?(AdminCompanyUser)
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
