# frozen_string_literal: true

class AdminCouponsController < ApplicationController
  before_action :get_store_name, only: %i(index coupons_detail new)
  def index; end

  def coupons_detail
    if params[:coupon_type].present? && params[:store_id].present?
      @coupons = Coupon.where(store_id: params[:store_id], coupon_type_id: params[:coupon_type]).order(:expiration_date)
    else
      redirect_to admin_stores_path
    end
  end

  def show
    @coupon = Coupon.find(params[:id])
  end

  def new
    @coupon = Coupon.new
  end

  def edit
    @coupon = Coupon.find(params[:id])
    @store_name = Store.find(@coupon.store_id)&.name
  end

  def create
    @coupon = Coupon.new(coupon_params)

    if @coupon.save
      flash[:success] = "クーポンを追加しました。"
      redirect_to coupons_detail_admin_coupons_path(coupon_type: params[:coupon][:coupon_type_id], store_id: params[:coupon][:store_id])
    else
      flash[:error] = @coupon.errors.full_messages
      redirect_to new_admin_coupon_path(coupon_type: params[:coupon][:coupon_type_id], store_id: params[:coupon][:store_id])
    end
  end

  def update
    @coupon = Coupon.find(params[:id])
    if @coupon.update(coupon_params)
      flash[:success] = "クーポンを更新しました。"
      redirect_to coupons_detail_admin_coupons_path(coupon_type: @coupon&.coupon_type_id, store_id: @coupon&.store_id)
    else
      flash[:error] = @coupon.errors.full_messages
      redirect_to edit_admin_coupon_path(coupon_type: @coupon&.coupon_type_id, store_id: @coupon&.store_id)
    end
  end

  def destroy
    @coupon = Coupon.find(params[:id])
    @coupon.destroy
    redirect_to coupons_detail_admin_coupons_path(coupon_type: @coupon&.coupon_type_id, store_id: @coupon&.store_id)
  end

  private

  def coupon_params
    params.require(:coupon).permit(:store_id, :title, :usage_terms, :presentation_terms, :bikou, :coupon_type_id, :expiration_date, :unlimited)
  end

  def get_store_name
    @store_name = if params[:store_id].present?
                    Store.find(params[:store_id])&.name
                  else
                    "無名"
                  end
  end
end
