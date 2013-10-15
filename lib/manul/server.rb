require 'eventmachine'
require 'manul/connection'

module Manul
  class Server
    attr_accessor :em_signature, :host, :path, :port

    def initialize(options)
      @host = options[:host] || 'localhost'
      @port = options[:port]
      @path = options[:path]
    end

    def start
      @em_signature = EventMachine.start_server @host, @port, Connection
    end

    def stop
      EventMachine.stop_server @em_signature
    end
  end
end
