class MoveType < ActiveRecord::Base
    attr_accessible :account_id, :name, :income

  belongs_to :account
  has_many :moves

  def income?
    return "+" if self.income
    return "-"
  end

  scope :account_move_types, lambda {|acc| {:conditions => {:account_id => acc}}}
  scope :visible, lambda {|acc| {:conditions => {:account_id => acc}}}

end
