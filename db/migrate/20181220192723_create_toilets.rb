class CreateToilets < ActiveRecord::Migration[5.2]
  def change
    create_table :toilets do |t|
      t.text :name, null: false
      t.text :slug, null: false
      t.column :gender, :gender_enum, null: false
      t.references :building, null: false
      t.references :floor, null: false
      t.integer :stalls
      t.integer :urinals
      t.integer :sinks
      t.text :comments
      t.text :creator, null: false

      t.timestamps
    end


    add_index :toilets, [:building_id, :floor_id, :name], :unique => true
    add_index :toilets, [:building_id, :floor_id, :slug], :unique => true
  end
end
