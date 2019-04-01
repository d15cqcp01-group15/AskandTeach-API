class Course < ApplicationRecord
  belongs_to :user
  has_many :detail_courses

  enum skill: %i[listening speaking reading writing]
  JSON_AGUMENT = [:id, :price, :uptime, :skill, :district, :city, :address, :description].freeze

  def amount_student
    self.detail_course.count
  end
end
