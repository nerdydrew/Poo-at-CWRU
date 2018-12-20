class CreateFloors < ActiveRecord::Migration[5.2]
  def change
    create_table :floors do |t|
      t.text :name
      t.text :slug, :null => false
      t.integer :level, :null => false, :limit => 1

      t.timestamps
    end

    add_reference :floors, :building, foreign_key: true, null: false

    add_index :floors, [:building_id, :slug], :unique => true
    add_index :floors, [:building_id, :level], :unique => true
  end
end
