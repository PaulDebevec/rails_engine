class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.all
    render json: serialized_merchants(merchants).serialized_json
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: serialized_merchants(merchant).serialized_json
  end

  def create
    new_merchant = Merchant.create(merchant_params)
    render json: serialized_merchants(new_merchant).serialized_json
  end

  def update
    updated_merchant = Merchant.update(params[:id], merchant_params)
    render json: serialized_merchants(updated_merchant).serialized_json
  end

  def destroy
    destroy_merchant = Merchant.destroy(params[:id])
    render json: serialized_merchants(destroy_merchant)
  end

  private

  def merchant_params
    params.permit(:name)
  end

  def serialized_merchants(merchant_data)
    MerchantSerializer.new(merchant_data)
  end
end
