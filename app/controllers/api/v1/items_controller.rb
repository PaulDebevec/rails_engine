class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.all
    render json: serialized_items(items).serialized_json
  end

  def show
    item = Item.find(params[:id])
    render json: serialized_items(item).serialized_json
  end

  def create
    created_item = Item.create(item_params)
    render json: serialized_items(created_item).serialized_json
  end

  def update
    updated_item = Item.update(params[:id], item_params)
    render json: serialized_items(updated_item).serialized_json
  end

  def destroy
    destroy_item = Item.destroy(params[:id])
    render json: serialized_items(destroy_item)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

  def serialized_items(item_data)
    ItemSerializer.new(item_data)
  end
end
