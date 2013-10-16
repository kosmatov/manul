require 'test_helper'

class RequestTest < Minitest::Test
  def setup
    @request = Manul::Request.new
  end

  def test_parse
    @request.parse 'GET /sample.txt HTTP/1.1'
    env = @request.env

    assert_equal 'GET', env[:method]
    assert_equal '/sample.txt', env[:filepath]
    assert_equal 'HTTP/1.1', env[:proto]
  end
end
