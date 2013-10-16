module Manul
  class Server
    def initialize(options)
      @connections = []
      @host = options[:host] || '127.0.0.1'
      @port = options[:port]
      @path = options[:path]
    end

    def start
      EventMachine.run do
        @em_signature = EventMachine.start_server @host, @port, Connection, &method(:init_connection)
      end
    end

    def stop
      EventMachine.stop_server @em_signature
      @connections.each(&:close)
      EventMachine.stop
    end

    def close_connection(connection)
      @connections.reject! { |c| c == connection }
    end

    protected

    def init_connection(connection)
      connection.app = App.new path: @path
      connection.server = self
      @connections << connection
    end
      
  end
end
