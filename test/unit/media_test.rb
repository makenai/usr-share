require 'test_helper'

class MediaTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Media.new.valid?
  end
end
