require 'test_helper'

class ServerTest < Minitest::Test
  def test_run_server
    server = Manul::Server.new port: 8080, path: '/tmp'
    assert server
  end
end

