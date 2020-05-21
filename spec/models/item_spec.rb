require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :unit_price}
  end

  describe 'relationships' do
    it {should belong_to :merchant}
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'class methods' do
    it ".find_item_name(name)" do
      merchant = create(:merchant)
      item_1 = merchant.items.create!(name: "Sobe", description: "Tasty", unit_price: 2.98)
      item_2 = merchant.items.create!(name: "Tommy Knockers", description: "Root Beer", unit_price: 1.99)
      item_3 = merchant.items.create!(name: "Vitamin Water", description: "Has vitamins, apparently", unit_price: 0.99)

      search_item_1 = Item.find_item_name('Sobe')
      expect(search_item_1).to eq(item_1)

      search_item_2 = Item.find_item_name('Tommy Knockers')
      expect(search_item_2).to eq(item_2)

      search_item_3 = Item.find_item_name('Vitamin Water')
      expect(search_item_3).to eq(item_3)
    end
  end
end
