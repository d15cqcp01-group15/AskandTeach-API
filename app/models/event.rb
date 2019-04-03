class Event < ApplicationRecord

  belongs_to :user
  has_many :detail_events

  def amount_student
    self.detail_events.count
  end
end
