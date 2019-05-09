class RemoveOpenTimeFromCourse < ActiveRecord::Migration[5.2]
  def change
    remove_column :courses, :open_time, :timestamp
  end
end
