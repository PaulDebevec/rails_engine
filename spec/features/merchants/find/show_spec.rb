require 'rails_helper'

RSpec.describe 'I send a get request to merchants find', type: :request do
  it 'the request searches the merchant by name' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    merchant_4 = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant_3.name.downcase}"
    json = JSON.parse(response.body)

    expect(json["data"].length).to eq(3)
    expect(json["data"]["id"].to_i).to eq(merchant_3.id)
    expect(json["data"]["type"]).to eq("merchant")
    expect(json["data"]["attributes"]["name"]).to eq(merchant_3.name)
  end
end
