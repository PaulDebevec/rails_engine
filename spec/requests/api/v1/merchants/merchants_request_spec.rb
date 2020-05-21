require 'rails_helper'

RSpec.describe "Merchants API", type: :request do
  it "sends a list of merchants" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)
    expect(merchants["data"].length).to eq(3)
    expect(merchants["data"][0]["id"].to_i).to eq(merchant_1.id)
    expect(merchants["data"][0]["attributes"]["name"]).to eq(merchant_1.name)
    expect(merchants["data"][0]["type"]).to eq('merchant')
    expect(merchants["data"][1]["id"].to_i).to eq(merchant_2.id)
    expect(merchants["data"][1]["attributes"]["name"]).to eq(merchant_2.name)
    expect(merchants["data"][1]["type"]).to eq('merchant')
    expect(merchants["data"][2]["id"].to_i).to eq(merchant_3.id)
    expect(merchants["data"][2]["attributes"]["name"]).to eq(merchant_3.name)
    expect(merchants["data"][2]["type"]).to eq('merchant')
  end

  it "can get one merchant by its id" do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"

    merchant_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant_json['data']['id'].to_i).to eq(merchant.id)
    expect(merchant_json['data'].length).to eq(3)
    expect(merchant_json['data']['attributes']['name']).to eq(merchant.name)
    expect(merchant_json["data"]["type"]).to eq('merchant')

  end

  it "can create a new merchant" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_params = { name: "Grocery Store" }

    post "/api/v1/merchants", params: merchant_params
    new_merchant = Merchant.last
    expect(response).to be_successful

    merchant = JSON.parse(response.body)['data']

    expect(merchant['attributes'].length).to eq(1)
    expect(merchant['id'].to_i).to eq(new_merchant.id)
    expect(merchant['attributes']['name']).to eq(merchant_params[:name])
    expect(merchant['id'].to_i).not_to eq(merchant_1.id)
    expect(merchant['attributes']['name']).not_to eq(merchant_1.name)
    expect(merchant['id'].to_i).not_to eq(merchant_2.id)
    expect(merchant['attributes']['name']).not_to eq(merchant_2.name)
  end

  it "can update an existing merchant" do
    id = create(:merchant).id
    previous_name = Merchant.last.name
    merchant_params = { name: "Johnstown Liquor" }

    put "/api/v1/merchants/#{id}", params: merchant_params
    merchant = Merchant.find_by(id: id)

    expect(response).to be_successful
    expect(merchant.name).to_not eq(previous_name)
    expect(merchant.name).to eq("Johnstown Liquor")
  end

  it "can destroy a merchant" do
    merchant = create(:merchant)

    expect(Merchant.exists?(merchant.id)).to eq(true)

    expect{ delete "/api/v1/merchants/#{merchant.id}" }.to change(Merchant, :count).by(-1)

    expect(response).to be_successful
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
    expect(Merchant.exists?(merchant.id)).to eq(false)
  end
end
