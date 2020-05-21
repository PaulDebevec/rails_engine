require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'relationships' do
    it {should have_many :items}
    it {should have_many :invoices}
  end

  describe 'class methods' do
    it ".find_merchant_name(name)" do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)

      search_merch_1 = Merchant.find_merchant_name(merchant_1.name)
      expect(search_merch_1).to eq(merchant_1)

      search_merch_2 = Merchant.find_merchant_name(merchant_2.name)
      expect(search_merch_2).to eq(merchant_2)

      search_merch_3 = Merchant.find_merchant_name(merchant_3.name)
      expect(search_merch_3).to eq(merchant_3)
    end
  end
end
