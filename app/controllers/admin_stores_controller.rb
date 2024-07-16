# frozen_string_literal: true

class AdminStoresController < ApplicationController
  before_action :set_store, only: %i(edit update destroy show)
  before_action :authenticate_user, :redirect_not_logged_in, :redirect_not_session, :set_session_expiration

  def index
    if current_company_admin?
      store_id = current_admin&.store_id
      @stores = Store.where(id: store_id)
    else
      @stores = Store.order(id: :asc)
    end
  end

  def show; end

  def new
    @store = Store.new
    @store.business_hours.build
  end

  def edit
    @store.business_hours.build if @store.business_hours.empty?
  end

  def create
    @store = Store.new(store_params)
    if @store.save
      flash[:success] = "店舗情報を追加しました"
      redirect_to admin_stores_path
    else
      flash[:error] = @store.errors.full_messages
      redirect_to new_admin_store_path
    end
  end

  def update
    if @store.update(store_params)
      flash[:success] = "店舗情報を更新しました"
    else
      flash[:error] = @store.errors.full_messages
    end
    redirect_to edit_admin_store_path(@store)
  end

  def destroy
    @store.destroy
    flash[:destroy] = "店舗情報を削除しました"
    redirect_to admin_stores_path
  end

  def view_counts
    @store = Store.find(params[:id])

    # 今月の投稿の全てのview_countカラムを合計
    Time.zone.now.beginning_of_month
    @current_month_view_count = Post.where(store_id: @store.id)
      .sum(:view_count)

    # store_idが@store.idの投稿の月毎の閲覧数を取得
    store_view_counts_data = StoreMonthlyPostView.where(store_id: @store.id)
      .group("DATE_TRUNC('month', view_month)")
      .sum(:view_counts)
      .transform_keys{|date| date.strftime("%Y-%m")}

    # 1月から12月までの全ての月を含むハッシュを作成
    current_year = Time.zone.now.year
    all_months = (1..12).map{|month| Date.new(current_year, month, 1).strftime("%Y-%m")}

    @all_view_counts = all_months.index_with do |year_month|
      store_view_counts_data[year_month] || 0
    end

    current_year_month = Time.zone.now.strftime("%Y-%m")
    @all_view_counts[current_year_month] = @current_month_view_count
  end

  private

  def set_store
    @store = Store.find(params[:id])
  end

  def store_params
    params.require(:store).permit(:name, :tel, :address, :google_map_url, :access, :access2,
                                  :nearest_station, :nearest_station2, :sales_time_lanch_weekday,
                                  :sales_time_lanch_holiday, :sales_time_dinner_weekday,
                                  :sales_time_dinner_holiday, :holiday, :pay_methods, :homepage_url,
                                  :sns_link_tabelog, :sns_link_twitter, :sns_link_instagram,
                                  :sns_link_facebook, :sns_link_line, :sales_flg,
                                  business_hours_attributes: [:id, :store_id, :opening_time, :closing_time, :opening_time2, :closing_time2, :last_order_time, :last_order_time2, :_destroy, {day_of_week: []}])
  end
end
