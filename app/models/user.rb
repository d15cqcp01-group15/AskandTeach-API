class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password,
         length: { minimum: 6 },
         if: -> { new_record? || !password.nil? }

  has_many :courses
  has_many :events
  has_many :topics

  mount_uploader :avatar, AvatarUploader

  PERMIT_PARAMS = %i[
  username
  email
  avatar
  password
  password_confirmation
  ].freeze
end
