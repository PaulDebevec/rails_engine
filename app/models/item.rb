class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price

  belongs_to :merchant, :dependent => :destroy
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.find_item_name(name)
    where('LOWER(items.name) = LOWER(?)', name).first
  end
end
