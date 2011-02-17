# encoding: utf-8 
class MovesPeople < ActiveRecord::Migration
  def self.up
    moves = Move.all
    for move in moves do
      if person = Person.find_by_name(move.notice.squish)
        move.person_id = person.id
        move.save
      end
    end
  end

  def self.down
  end
end
