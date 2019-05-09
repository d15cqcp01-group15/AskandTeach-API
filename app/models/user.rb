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
  has_many :detail_courses
  has_many :detail_events

  mount_uploader :avatar, AvatarUploader

  DEFAULT_IMAGE = 'http://farrellaudiovideo.com/wp-content/uploads/2016/02/default-profile-pic-300x300.png'

  def opened_class
    self.detail_courses.count
  end

  def joined_event
    self.detail_events.count
  end

  def update_image_for_defaul_user
    self.profile_image = DEFAULT_IMAGE
  end

  PERMIT_PARAMS = %i[
    username
    email
    avatar
    password
    password_confirmation
  ].freeze
end
