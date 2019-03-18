class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.references :user, foreign_key: true
      t.string :address
      t.string :district
      t.string :city
      t.date :uptime
      t.float :price
      t.string :description

      t.timestamps
    end
  end
end
