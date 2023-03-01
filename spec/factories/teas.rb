# frozen_string_literal: true

FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Lorem.sentence }
    temperature { Faker::Number.within(range: 140..255) }
    brew_time { Faker::Number.within(range: 60..280) }
  end
end
