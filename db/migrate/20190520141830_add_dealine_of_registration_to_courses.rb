class AddDealineOfRegistrationToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :deadline_of_registration, :float
    add_column :courses, :status, :boolean
  end
end
