class CreateBuildings < ActiveRecord::Migration[5.2]
  def change

    reversible do |dir|
      dir.up {execute <<-DDL
          CREATE TYPE building_type_enum AS ENUM (
            'academic','administrative','athletic','other','residential','restaurant'
          );
        DDL
      }
      dir.down{execute <<-DDL
          DROP TYPE IF EXISTS building_type_enum;
        DDL
      }
    end

    create_table :buildings do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.string :blurb
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.column :type, :building_type_enum
      t.timestamps
    end
  end
end
