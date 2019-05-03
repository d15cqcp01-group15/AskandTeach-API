class AddLongitudeAndlatitudeToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :longitude, :float
    add_column :courses, :latitude, :float
  end
end
