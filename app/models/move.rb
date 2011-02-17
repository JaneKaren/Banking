class Move < ActiveRecord::Base
  attr_accessible :user_id, :account_id, :move_type_id, :amount, :date, :person_id, :notice

  belongs_to :user
  belongs_to :account
  belongs_to :move_type

  has_one :person

  scope :mine , lambda {|user| where(:user_id => user)}
  scope :account_moves, lambda {|acc| where(:account_id => acc)}
  scope :acc_moves_by_type, lambda {|mtp| where(:move_type_id => mtp)}
  scope :obydateamount, order("date desc, amount desc")

end
