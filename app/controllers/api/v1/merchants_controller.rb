class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all).serialized_json
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id])).serialized_json
  end

  def create
    render json: MerchantSerializer.new(Merchant.create(merchant_params)).serialized_json
  end

  def update
    render json: MerchantSerializer.new(Merchant.update(params[:id], merchant_params)).serialized_json
  end

  def destroy
    render json: MerchantSerializer.new(Merchant.destroy(params[:id]))
  end

  private

  def merchant_params
    params.permit(:name)
  end
end
