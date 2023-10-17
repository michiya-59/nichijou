class AdminSessionsController < ApplicationController
  def new
  end

  def create
    admin = AdminUser.find_by(login_id: params[:login_id])
    if admin && admin.authenticate(params[:password])
      login admin
      redirect_to posts_path
    else
      flash[:alert] = 'ログインIDまたはパスワードが間違っています'
      redirect_to admin_login_path
    end
  end
  
  def destroy
    session.delete(:admin_id)
    flash[:logout] = 'ログアウトしました'
    redirect_to admin_login_path
  end
end
