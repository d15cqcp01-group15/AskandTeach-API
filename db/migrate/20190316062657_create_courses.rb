class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.references :user, foreign_key: true
      t.float :price
      t.date :uptime
      t.integer :skill
      t.string :district
      t.string :city
      t.string :address
      t.string :description

      t.timestamps
    end
  end
end
