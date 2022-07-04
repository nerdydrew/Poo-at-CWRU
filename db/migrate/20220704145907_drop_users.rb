class DropUsers < ActiveRecord::Migration[6.1]
  def change
    drop_table :users
  end
end
