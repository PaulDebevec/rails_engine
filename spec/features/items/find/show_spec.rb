require 'rails_helper'

RSpec.describe 'I send a get request to merchants find', type: :request do
  it 'the request finds the merchant by name' do
    item_1 = create(:item)
    item_2 = create(:item)
    item_3 = create(:item)
    item_4 = create(:item)

    get "/api/v1/items/find?name=#{item_3.name.downcase}"
    json = JSON.parse(response.body)

    expect(json["data"].length).to eq(3)
    expect(json["data"]["id"].to_i).to eq(item_3.id)
    expect(json["data"]["type"]).to eq("item")
    expect(json["data"]["attributes"]["name"]).to eq(item_3.name)
  end
end
