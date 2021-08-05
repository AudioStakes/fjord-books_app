# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :following, class_name: 'User'

  validates :follower, uniqueness: { scope: :following }
  validate :must_not_follow_youlself

  private

  def must_not_follow_youlself
    return unless follower == following

    errors.add(:base, :must_not_follow_youlself)
  end
end
