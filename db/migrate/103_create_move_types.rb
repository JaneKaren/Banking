class CreateMoveTypes < ActiveRecord::Migration
  def self.up
    create_table :move_types do |t|
      t.integer :account_id
      t.string :name, :null => false, :length => 30
      t.boolean :income, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :move_types
  end
end
