class Event < ApplicationRecord
  belongs_to :user
  has_many :detail_events

  def amount_student
    self.detail_events.count
  end

  EVENT_AGUMENT = [:id, :title, :address, :description, :district, :city, :uptime, :price, :amount_student, :open_time]
end
