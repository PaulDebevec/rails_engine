class Api::V1::Items::FindController < ApplicationController
  def show
    item = if params['name']
      Item.find_item_name(params['name'])
    end
    render json: ItemSerializer.new(item)
  end
end
