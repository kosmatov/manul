require 'test_helper'

class ConnectionTest < Minitest::Test
  def setup
    @connection = Manul::Connection.new mock('EM')
    EventMachine.stubs(:send_data)

    path = File.expand_path File.dirname(__FILE__), '..'
    path = File.join path, '/fixtures'

    server = Manul::Server.new path: path
    @connection.server = server
    @connection.app = Manul::App.new path: path
  end

  def test_receive_data
    request_data = 'GET /sample.txt'
    @connection.receive_data request_data
  end
end
