require 'test_helper'

class MoveTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Move.new.valid?
  end
end
