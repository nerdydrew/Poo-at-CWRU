class RenameToRestroom < ActiveRecord::Migration[6.1]
  def change
    rename_table :toilets, :restrooms
    rename_column :reviews, :toilet_id, :restroom_id
  end
end
