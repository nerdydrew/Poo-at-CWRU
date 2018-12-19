class AddIndexOnCaseId < ActiveRecord::Migration[5.2]
  def change
  	add_index :users, :case_id, :unique => true
  end
end
