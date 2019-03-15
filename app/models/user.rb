class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password,
         length: { minimum: 6 },
         if: -> { new_record? || !password.nil? }

  PERMIT_PARAMS = %i[
  username
  email
  password
  password_confirmation
  ].freeze
end
