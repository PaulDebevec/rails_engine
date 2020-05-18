FactoryBot.define do
  factory :item do
    name { Faker::Beer.name }
    description { Faker::Beer.style }
    unit_price { "7.28" }
  end
end
