FactoryBot.define do
  factory :subscription do
    customer { nil }
    tea { nil }
    title { Faker::Lorem.word }
    price { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    status { "active" }
    frequency { Faker::Number.within(range: 1..10) }
  end
end
