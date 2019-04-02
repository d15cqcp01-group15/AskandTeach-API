class AddAmountStudentToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :amount_student, :integer
  end
end
