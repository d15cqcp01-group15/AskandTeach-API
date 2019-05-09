class AddOpenTimeToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :open_time, :float
  end
end
