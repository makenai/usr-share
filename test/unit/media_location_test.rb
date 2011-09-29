require 'test_helper'

class MediaLocationTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert MediaLocation.new.valid?
  end
end
