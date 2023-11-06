# frozen_string_literal: true

class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:success] = "お問い合わせを受け付けました。<br>入力されたメールアドレス宛に返信メールをしますので、今しばらくお待ちください。"
      redirect_to new_contact_path
    else
      # 保存に失敗した場合の処理をここに記述します。
      # 例: 入力フォームを再表示します。
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:inquiry_type, :email, :name, :tel, :content)
  end
end
