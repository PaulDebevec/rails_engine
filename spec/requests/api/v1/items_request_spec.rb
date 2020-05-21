require 'rails_helper'

RSpec.describe "Items API", type: :request do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)
  end

  it "can get one item by its id" do
    id = create(:item).id.to_s

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item['data']['id']).to eq(id)
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
    expect(item['attributes']['name']).to eq(item_params[:name])
    expect(item['attributes']['description']).to eq(item_params[:description])
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
