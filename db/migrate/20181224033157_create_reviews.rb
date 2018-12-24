class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :toilet, foreign_key: true
      t.string :user, null: false
      t.integer :cleanliness
      t.integer :location
      t.integer :wifi
      t.integer :writing
      t.integer :traffic
      t.integer :toilet_paper
      t.integer :overall, null: false
      t.string :comments, null: false

      t.timestamps
    end

    add_index :reviews, [:toilet_id, :user], :unique => true
  end
end