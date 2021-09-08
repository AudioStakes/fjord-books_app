# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    name { Faker::Name.name }
    postal_code { Faker::Address.zip_code.remove('-') }
    address { Faker::Address.full_address }
    self_introduction { Faker::Lorem.paragraph }
  end
end
