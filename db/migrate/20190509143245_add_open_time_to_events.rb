class AddOpenTimeToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :open_time, :float
  end
end
