class Course < ApplicationRecord
  before_save :update_cover_image

  belongs_to :user
  has_many :detail_courses

  enum skill: %i[listening speaking reading writing]

  JSON_AGUMENT = [:id, :price, :uptime, :skill, :district, :city, :address, :description, :cover_image, :amount_student].freeze

  LIST_URL = 'https://res.cloudinary.com/no-nam/image/upload/v1554172948/listening.jpg'
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
  end

  def amount_student
    self.detail_courses.count
  end
end
