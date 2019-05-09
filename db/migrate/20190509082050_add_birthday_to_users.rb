class AddBirthdayToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :birthday, :date
    add_column :users, :opened_class, :integer
    add_column :users, :joined_event, :integer
    add_column :users, :self_introduce, :string
  end
end
