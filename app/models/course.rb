class Course < ApplicationRecord
  before_save :update_cover_image

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  reverse_geocoded_by :latitude, :longitude

  belongs_to :user
  has_many :detail_courses

  enum skill: %i[listening speaking reading writing]

  JSON_AGUMENT = [
    :id, :price, :uptime,
    :skill, :district, :city,
    :address, :longitude, :latitude,
    :description, :cover_image, :amount_student,
    :list_student, :class_opened, :open_time,
    :deadline_of_registration, :status, :state
  ].freeze

  COURSE_PARAMS = ['price', 'uptime', 'skill', 'district', 'city', 'address', 'description', 'open_time', 'deadline_of_registration'].freeze

  LIST_URL = 'https://res.cloudinary.com/no-nam/image/upload/v1554216712/listen.jpg'
  READ_URL = 'https://res.cloudinary.com/no-nam/image/upload/v1554172721/reading.jpg'
  WRITE_URL = 'https://res.cloudinary.com/no-nam/image/upload/v1554172781/writing.jpg'
  SPEAK_URL = 'https://res.cloudinary.com/no-nam/image/upload/v1554172881/speaking.jpg'

  def update_cover_image
    if self.speaking?
      self.cover_image = SPEAK_URL
    end
    if self.reading?
      self.cover_image = READ_URL
    end
    if self.writing?
      self.cover_image = WRITE_URL
    end
    if self.listening?
      self.cover_image = LIST_URL
    end
    if self.deadline_of_registration.nil?
      time = Time.zone.now + 172800
      self.deadline_of_registration = time.to_f
    end
  end

  private

  def amount_student
    self.detail_courses.count
  end

  def list_student
    student_list = self.detail_courses.pluck(:user_id)
    return User.where(id: student_list).pluck(:username)
  end

  def class_opened
    self.user.courses.count
  end

  def status
    openning = Time.at(self.deadline_of_registration).future?
    return 'openning' if openning
    'closes'
  end
end
