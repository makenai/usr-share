require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Room.new.valid?
  end
end
