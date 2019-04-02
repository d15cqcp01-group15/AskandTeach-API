class AddListStudentToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :list_student, :string, array: true
  end
end
