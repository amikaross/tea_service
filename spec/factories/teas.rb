FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Lorem.sentence }
    temperature { Faker::number.within(range: 140..255) }
    brew_time { Faker::number.within(range: 60..280) }
  end
end
