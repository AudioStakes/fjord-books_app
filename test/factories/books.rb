# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    memo { Faker::Book.genre }
    author { Faker::Book.author }
    picture { Rails.root.join('test/fixtures/files/no-image.png').open }
  end
end
