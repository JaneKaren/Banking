class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :name, :length => 50
      t.string :house, :length => 30
      t.boolean :frozen, :default => false
      t.date :frozen_date
      t.boolean :deleted, :default => false
      t.date :delete_date
      t.integer :year
      t.timestamps
    end
    
    rename_column(:moves, :loan_id, :person_id)
    
  end

  def self.down
    drop_table :people
    
    rename_column(:moves, :person_id, :loan_id)
  end
end
