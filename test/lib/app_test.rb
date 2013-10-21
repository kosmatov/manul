require 'test_helper'

class AppTest < Minitest::Test
  def setup
    path = File.expand_path '..', File.dirname(__FILE__)
    @path = File.join path, '/fixtures'

    @parser = Http::Parser.new
    @app = Manul::App.new path: @path
  end

  def test_ok
    @parser << "GET /sample.txt HTTP/1.1\r\n"

    filename = File.join @path, @parser.request_url
    file = File.open filename

    status, headers, content = @app.call(@parser)

    assert_equal 200, status
    assert_equal file.path, content.path
    assert headers.any?
  end

  def test_not_found
    @parser << "GET /not_existence.txt HTTP/1.1\r\n"
    status, headers, content = @app.call(@parser)

    assert_equal 404, status
    assert content['Not']
    assert headers.any?
  end

  def test_forbidden
    @parser << "GET /../test_helper.rb HTTP/1.1\r\n"

    status, headers, content = @app.call(@parser)

    assert_equal 403, status
    assert content['Forbidden']
    assert headers.any?
  end

end
