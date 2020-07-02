require "test_helper"

class PolyJsonTest < Minitest::Test
  def test_empty_json
    expected = {}
    assert_equal expected, PolyJson.load('{}')
  end
end
