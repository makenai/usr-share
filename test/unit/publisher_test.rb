require 'test_helper'

class PublisherTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Publisher.new.valid?
  end
end
