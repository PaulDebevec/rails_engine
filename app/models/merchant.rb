class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices

  def self.find_merchant_name(name)
    where('LOWER(merchants.name) = LOWER(?)', name).first
  end
end
