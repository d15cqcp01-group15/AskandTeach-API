class AddAmountStudentToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :amount_student, :integer
  end
end
