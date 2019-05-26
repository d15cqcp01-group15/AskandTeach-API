class AddStateToCourse < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :state, :boolean, default: true
  end
end
