class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all).serialized_json
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id])).serialized_json
  end

  def create
    render json: ItemSerializer.new(Item.create(item_params)).serialized_json
  end

  def update
    render json: ItemSerializer.new(Item.update(params[:id], item_params)).serialized_json
  end

  def destroy
    render json: ItemSerializer.new(Item.destroy(params[:id]))
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
