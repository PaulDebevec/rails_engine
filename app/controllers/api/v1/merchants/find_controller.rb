class Api::V1::Merchants::FindController < ApplicationController
  def show
    merchant = if params['name']
      Merchant.find_merchant_name(params['name'])
    end
    render json: MerchantSerializer.new(merchant)
  end
end
