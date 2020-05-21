require 'rails_helper'

RSpec.describe "Merchant Items API", type: :request do
  it "sends a list of items belonging to that merchant" do
    merchant = create(:merchant)
    item_1 = merchant.items.create!(name: "Sobe", description: "Tasty", unit_price: 2.98)
    item_2 = merchant.items.create!(name: "Tommy Knockers", description: "Root Beer", unit_price: 1.99)
    item_3 = merchant.items.create!(name: "Vitamin Water", description: "Has vitamins, apparently", unit_price: 0.99)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    merchant_items = JSON.parse(response.body)
    expect(merchant_items["data"].count).to eq(3)
    expect(merchant_items["data"][0]["id"].to_i).to eq(item_1.id)
    expect(merchant_items["data"][0]["type"]).to eq("item")
    expect(merchant_items["data"][0]["attributes"]["name"]).to eq(item_1.name)
    expect(merchant_items["data"][1]["id"].to_i).to eq(item_2.id)
    expect(merchant_items["data"][1]["type"]).to eq("item")
    expect(merchant_items["data"][1]["attributes"]["name"]).to eq(item_2.name)
    expect(merchant_items["data"][2]["id"].to_i).to eq(item_3.id)
    expect(merchant_items["data"][2]["type"]).to eq("item")
    expect(merchant_items["data"][2]["attributes"]["name"]).to eq(item_3.name)
  end
end
