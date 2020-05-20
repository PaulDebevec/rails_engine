FactoryBot.define do
  factory :item, class: Item do
    association :merchant
    name { Faker::Beer.name }
    description { Faker::Beer.style }
    unit_price { "7.28" }
  end
end
