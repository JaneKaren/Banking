class Move < ActiveRecord::Base
  attr_accessible :user_id, :account_id, :move_type_id, :amount, :date, :loan_id, :notice

  belongs_to :user
  belongs_to :account
  belongs_to :move_type

  scope :mine , lambda {|user| {:conditions => {:user_id => user}}}
  scope :account_moves, lambda {|acc| {:conditions => {:account_id => acc}}}
  scope :acc_moves_by_type, lambda {|mtp| {:conditions => {:move_type_id => mtp}}}

end
