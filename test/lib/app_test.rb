require 'test_helper'

class AppTest < Minitest::Test
  def setup
    path = File.expand_path '..', File.dirname(__FILE__)
    @path = File.join path, '/fixtures'

    @app = Manul::App.new path: @path
  end

  def test_ok
    env = {
      method: 'GET',
      filepath: '/sample.txt'
    }

    filename = File.join @path, env[:filepath]
    file = File.open filename

    status, headers, content = @app.call(env)

    assert_equal 200, status
    assert_equal file.path, content.path
    assert headers.any?
  end

  def test_not_found
    env = {
      method: 'get',
      filepath: '/not_existence_file'
    }

    status, headers, content = @app.call(env)

    assert_equal 404, status
    assert content['Not']
    assert headers.any?
  end

  def test_bad_request
    env = {
      method: 'bad',
      filepath: '/sample.txt'
    }

    status, headers, content = @app.call(env)

    assert_equal 400, status
    assert content['Bad']
    assert headers.any?
  end

  def test_forbidden
    env = {
      method: 'get',
      filepath: '../test_helper.rb'
    }

    status, headers, content = @app.call(env)

    assert_equal 403, status
    assert content['Forbidden']
    assert headers.any?
  end

end
