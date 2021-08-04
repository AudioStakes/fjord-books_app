# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :icon

  validate :content_type_of_icon_must_be_allowed

  private

  def content_type_of_icon_must_be_allowed
    allowed_file_types = ['image/png', 'image/jpeg', 'image/gif']

    return if icon.content_type.in?(allowed_file_types)

    errors.add(:icon, :invalid)
  end
end
