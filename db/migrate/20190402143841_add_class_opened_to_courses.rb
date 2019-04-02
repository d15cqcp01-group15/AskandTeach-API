class AddClassOpenedToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :class_opened, :integer
  end
end
