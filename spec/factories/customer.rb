FactoryBot.define do
  factory :customer do
    first_name { Faker::Esport.player }
    last_name { Faker::Esport.player }
  end
end
