FactoryBot.define do
  factory :item, class: Item do
    association :merchant
    name { Faker::Beer.name }
    description { Faker::Beer.style }
    unit_price { Faker::Number.decimal(l_digits: 2) }
  end
end
