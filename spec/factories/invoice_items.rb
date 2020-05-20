FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.between(from: 1, to: 299) }
  end
end
