require 'test_helper'

class ConnectionTest < Minitest::Test
  def setup
    @connection = Manul::Connection.new mock('EM')
    EventMachine.stubs(:send_data)

    server = Manul::Server.new path: '/tmp'
    @connection.server = server
    @connection.app = Manul::App.new path: '/tmp'
  end

  def test_receive_data
    request_data = 'GET /sample.txt'
    @connection.receive_data request_data
  end
end
