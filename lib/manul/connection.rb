module Manul
  class Connection < EM::Connection
    attr_accessor :server, :app

    def post_init
      @parser = Http::Parser.new
    end

    def receive_data(data)
      @parser << data
      post_process pre_process
    rescue
    end

    def pre_process
      @app.call @parser
    end

    def post_process(result)
      send_data @parser.headers
      @parser.on_body = proc do |chunk|
        send_data chunk
      end unless head_method?
    ensure
      close
    end

    def close
      @server.close_connection self
    end

    private

    def head_method?
      @parser.http_method == 'HEAD'
    end
  end
end
