class MakeBuildingNamesUnique < ActiveRecord::Migration[5.2]
  def change
  	add_index :buildings, :name, unique: true
  	add_index :buildings, :slug, unique: true
  end
end
