require 'test_helper'

class JsonApiClientMockTest < MiniTest::Unit::TestCase
  def test_truth
    assert_kind_of Module, JsonApiClientMock
  end
end
