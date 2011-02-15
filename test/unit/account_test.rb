require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Account.new.valid?
  end
end
