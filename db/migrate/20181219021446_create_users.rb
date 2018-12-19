class CreateUsers < ActiveRecord::Migration[5.2]
  def change

    reversible do |dir|
      dir.up {execute <<-DDL
          CREATE TYPE gender_enum AS ENUM (
            'male', 'female', 'any'
          );
        DDL
      }
      dir.down{execute <<-DDL
          DROP TYPE IF EXISTS gender_enum;
        DDL
      }
    end

    create_table :users do |t|
      t.string :case_id, null: false
      t.column :gender, :gender_enum
      t.timestamps
    end
  end
end
