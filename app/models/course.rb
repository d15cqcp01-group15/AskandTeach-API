class Course < ApplicationRecord
  belongs_to :user
  has_many :detail_courses

  enum skill: %i[listening speaking reading writing]
end
