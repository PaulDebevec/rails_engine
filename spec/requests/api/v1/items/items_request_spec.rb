require 'rails_helper'

RSpec.describe "Items API", type: :request do
  it "sends a list of items" do
    item_1 = create(:item)
    item_2 = create(:item)
    item_3 = create(:item)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].length).to eq(3)
    expect(items["data"][0]["id"].to_i).to eq(item_1.id)
    expect(items["data"][0]["attributes"]["name"]).to eq(item_1.name)
    expect(items["data"][0]["attributes"]["description"]).to eq(item_1.description)
    expect(items["data"][1]["id"].to_i).to eq(item_2.id)
    expect(items["data"][1]["attributes"]["name"]).to eq(item_2.name)
    expect(items["data"][1]["attributes"]["description"]).to eq(item_2.description)
    expect(items["data"][2]["id"].to_i).to eq(item_3.id)
    expect(items["data"][2]["attributes"]["name"]).to eq(item_3.name)
    expect(items["data"][2]["attributes"]["description"]).to eq(item_3.description)
  end

  it "can get one item by its id" do
    item_1 = create(:item)
    item_2 = create(:item)
    item_3 = create(:item)

    get "/api/v1/items/#{item_1.id}"

    item_1_json = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item_1_json['data']['id'].to_i).to eq(item_1.id)
    expect(item_1_json['data'].length).to eq(3)
    expect(item_1_json['data']['id'].to_i).to eq(item_1.id)
    expect(item_1_json['data']['attributes']['name']).to eq(item_1.name)
    expect(item_1_json['data']['attributes']['description']).to eq(item_1.description)

    get "/api/v1/items/#{item_3.id}"

    item_3_json = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item_3_json['data']['id'].to_i).to eq(item_3.id)
    expect(item_3_json['data'].length).to eq(3)
    expect(item_3_json['data']['id'].to_i).to eq(item_3.id)
    expect(item_3_json['data']['attributes']['name']).to eq(item_3.name)
    expect(item_3_json['data']['attributes']['description']).to eq(item_3.description)
  end

  it "can create a new item" do
    merchant = create(:merchant)
    item_params = { name: "Cup o' Coffee", description: "It's good", unit_price: 3.99, merchant_id: merchant.id }
    item_1 = merchant.items.create!(name: "Sobe", description: "Tasty", unit_price: 2.98)
    item_2 = merchant.items.create!(name: "Tommy Knockers", description: "Root Beer", unit_price: 1.99)

    post "/api/v1/items", params: {item: item_params}
    expect(response).to be_successful

    new_item = Item.last

    expect(new_item.name).to eq(item_params[:name])

    item = JSON.parse(response.body)['data']

    expect(item['attributes'].length).to eq(4)
    expect(item['id'].to_i).to eq(new_item.id)
    expect(item['attributes']['name']).to eq(item_params[:name])
    expect(item['attributes']['description']).to eq(item_params[:description])
    expect(item['attributes']['unit_price']).to eq(item_params[:unit_price])
  end

  it "can update an existing item" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: "Johnstown Liquor" }

    patch "/api/v1/items/#{id}", params: {item: item_params}
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Johnstown Liquor")
  end

  it "can destroy a item" do
    item = create(:item)

    expect(Item.exists?(item.id)).to eq(true)

    expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)

    expect(response).to be_successful
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
    expect(Item.exists?(item.id)).to eq(false)
  end
end
