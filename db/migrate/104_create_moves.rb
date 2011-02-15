class CreateMoves < ActiveRecord::Migration
  def self.up
    create_table :moves do |t|
      t.integer :user_id
      t.integer :account_id
      t.integer :move_type_id
      t.decimal :amount, :default => 0.0
      t.date :date
      t.integer :loan_id
      t.string :notice, :default => ''
      t.timestamps
    end
  end

  def self.down
    drop_table :moves
  end
end
