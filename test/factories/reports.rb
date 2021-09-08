# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    user
  end
end
