class Course < ApplicationRecord
  belongs_to :user

  enum skill: %i[listening speaking reading writing]
end
