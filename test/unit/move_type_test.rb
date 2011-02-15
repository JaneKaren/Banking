require 'test_helper'

class MoveTypeTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert MoveType.new.valid?
  end
end
