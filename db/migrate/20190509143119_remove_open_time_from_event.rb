class RemoveOpenTimeFromEvent < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :open_time, :timestamp
  end
end
