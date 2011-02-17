class Account < ActiveRecord::Base
    attr_accessible :name

  has_many :ownerships
  has_many :users, :through => :ownerships, :uniq => true

  has_many :move_types
  has_many :moves

  def cash_flow(from = 100.years.ago, to = 100.years.since)
    cf = {}
    income = 0
    expense = 0
    @moves = self.moves.where('date BETWEEN ? AND ?', from, to)
    for move in @moves do
      if move.move_type.income
        income += move.amount
      else
        expense += move.amount
      end
    end

    cf[:in] = income
    cf[:ex] = expense
    cf[:profit] = (income - expense)
    
    return cf
  end

  def cf_show(what = 'cf')
    a = self.cash_flow
    return a[:in] if what == 'in'
    return a[:ex] if what == 'ex'
    return a[:profit] if what == 'cf'
  end

  def move_type_sum(from = 100.years.ago, to = 100.years.since)
    mts_hash = {}
    @mts = self.move_types
    i=0
    for mt in @mts do
      moves = self.moves.where("move_type_id = ? AND date BETWEEN ? AND ?", mt, from, to)
      sum = 0
      for mv in moves do
        sum += mv.amount
      end
      mts_hash[:name]=mt.name
      mts_hash[:sum]=sum
      i+=1
    end
    return mts_hash
  end

  def amount_to_date(date = Date.today)
    moves = self.moves.where('date <= ?', date)
    sum_to_date = 0
    for move in moves do
      if move.move_type.income
        sum_to_date += move.amount
      else
        sum_to_date -= move.amount
      end
    end
    return sum_to_date
  end
  
end
