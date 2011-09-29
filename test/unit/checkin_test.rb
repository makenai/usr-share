require 'test_helper'

class CheckinTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Checkin.new.valid?
  end
end
