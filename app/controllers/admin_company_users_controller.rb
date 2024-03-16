# frozen_string_literal: true

class AdminCompanyUsersController < ApplicationController
  require "csv"

  def index
    if params[:store_id].present?
      # store_idパラメータが存在する場合、そのIDに基づいて絞り込み
      @company_accounts = AdminCompanyUser.includes(:store).where(store_id: params[:store_id]).order(:store_id)
    else
      # store_idパラメータが存在しない場合、全てのアカウントを取得
      @company_accounts = AdminCompanyUser.includes(:store).order(:store_id)
    end

    @stores = Store.order(:name)
  end

  def new
    @admin_company_user = AdminCompanyUser.new
    @stores = Store.order(:name)
  end

  def create
    store = Store.find(params[:admin_company_user][:store_id])
    password = SecureRandom.alphanumeric(20)

    # CSVデータをメモリ内で生成
    csv_data = CSV.generate(headers: true) do |csv|
      csv << %w(ログインID パスワード 認証コード 店舗ID 店舗名) # ヘッダー追加

      unless AdminCompanyUser.exists?(store_id: store.id)
        login_id = SecureRandom.hex(4)
        authentication_code = SecureRandom.hex(10)

        # CSVに行を追加
        csv << [
          login_id,
          password,
          authentication_code,
          store.id,
          store.name # 会社名を追加
        ]

        # 実際にAdminCompanyUserを作成
        AdminCompanyUser.create!(
          login_id:,
          password:,
          authentication_code:,
          status: 1,
          store_id: store.id
        )
      end
    end

    # CSVファイルとしてユーザーにダウンロードさせる
    send_data csv_data, filename: "admin_company_user_#{Time.zone.now.strftime('%Y%m%d%H%M%S')}.csv"
  rescue StandardError => e
    flash[:alert] = "アカウント作成に失敗しました: #{e.message}"
    redirect_to new_admin_company_user_path
  end

  def bulk_create
    # CSVデータをメモリ内で生成
    csv_data = CSV.generate(headers: true) do |csv|
      csv << %w(ログインID パスワード 認証コード 店舗ID 店舗名) # ヘッダー

      Store.find_each do |store|
        # 既に登録されているstore_idのアカウントをスキップ
        next if AdminCompanyUser.exists?(store_id: store.id)

        password = SecureRandom.alphanumeric(20)
        login_id = SecureRandom.hex(4)
        authentication_code = SecureRandom.hex(10)

        # CSVに行を追加
        csv << [
          login_id,
          password,
          authentication_code,
          store.id,
          store.name
        ]

        # ここで実際にAdminCompanyUserを作成
        AdminCompanyUser.create!(
          login_id:,
          password:,
          authentication_code:,
          status: 1,
          store_id: store.id
        )
      end
    end
    # 処理完了後、適切なページにリダイレクトし、メッセージを表示
    # redirect_to admin_company_users_path, notice: '未登録の店舗アカウントのみが作成されました。'

    # CSVファイルとしてユーザーにダウンロードさせる
    send_data csv_data, filename: "admin_company_users_#{Time.zone.now.strftime('%Y%m%d%H%M%S')}.csv"
  end

  private

  def admin_company_user_params
    params.require(:admin_company_user).permit(:store_id)
  end
end
