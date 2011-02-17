class Person < ActiveRecord::Base
    attr_accessible :name, :house, :frozen, :frozen_date, :deleted, :delete_date, :year

  belongs_to :move

  def whole_name
    return "#{self.name} - #{self.house}"
  end

  def is_deleted?
    return "yes" if self.deleted
    return "no"
  end

  def is_frozen?
    return "yes" if self.frozen
    return "no"
  end

  scope :active, where(:deleted => false, :frozen => false)
  scope :obyname, order('name')

end
