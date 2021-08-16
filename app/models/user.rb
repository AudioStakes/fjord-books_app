# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :active_follows, class_name: 'Follow', foreign_key: :follower_id, dependent: :destroy, inverse_of: :follower
  has_many :followings, through: :active_follows

  has_many :passive_follows, class_name: 'Follow', foreign_key: :following_id, dependent: :destroy, inverse_of: :following
  has_many :followers, through: :passive_follows

  def follow!(user)
    active_follows.create!(following: user)
  end

  def unfollow!(user)
    active_follows.find_by!(following: user).destroy!
  end
end
