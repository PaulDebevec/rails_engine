require 'rails_helper'

RSpec.describe "Items Merchant API", type: :request do
  it "sends the merchant who the item belongs to" do
    merchant = create(:merchant)
    item_1 = merchant.items.create!(name: "Sobe", description: "Tasty", unit_price: 2.98)
    item_2 = merchant.items.create!(name: "Tommy Knockers", description: "Root Beer", unit_price: 1.99)
    item_3 = merchant.items.create!(name: "Vitamin Water", description: "Has vitamins, apparently", unit_price: 0.99)

    get "/api/v1/items/#{item_2.id}/merchant"

    expect(response).to be_successful

    merchant_items = JSON.parse(response.body)

    expect(merchant_items["data"].count).to eq(3)
    expect(merchant_items["data"]["id"].to_i).to eq(merchant.id)
    expect(merchant_items["data"]["type"]).to eq("merchant")
    expect(merchant_items["data"]["attributes"]["name"]).to eq(merchant.name)
  end
end
