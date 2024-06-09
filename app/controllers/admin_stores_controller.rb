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
                                  business_hours_attributes: [:id, :store_id, :opening_time, :closing_time, :opening_time2, :closing_time2, :last_order_time, :last_order_time2, :last_order_drink, :last_order_drink2, :_destroy, {day_of_week: []}])
  end
end
