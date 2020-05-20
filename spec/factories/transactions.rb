FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Bank.account_number(digits: 16) }
    credit_card_expiration_date { Faker::Date.in_date_period }
    result { "Success" }
  end
end
