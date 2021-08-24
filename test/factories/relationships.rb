# frozen_string_literal: true

FactoryBot.define do
  factory :relationship do
    following factory: :user
    follower factory: :user
  end
end
