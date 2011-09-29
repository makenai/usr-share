require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Member.new.valid?
  end
end
