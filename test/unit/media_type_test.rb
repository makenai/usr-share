require 'test_helper'

class MediaTypeTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert MediaType.new.valid?
  end
end
