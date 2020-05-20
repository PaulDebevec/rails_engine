class Api::V1::Merchants::MerchantItemsController < ApplicationController
  def index
    items = Merchant.find(params[:merchant_id]).items.order(:id)
    render json: ItemSerializer.new(items)
  end
end
