module Manul
  class Connection < EM::Connection
    attr_accessor :server, :app

    def post_init
      @request = Request.new
      @response = Response.new
    end

    def receive_data(data)
      @request.parse(data)
      post_process pre_process
    end

    def pre_process
      @app.call @request.env
    end

    def post_process(result)
      @response.status, @response.headers, @response.body = *result
      @response.each do |chunk|
        send_data chunk
      end
    ensure
      close
    end

    def close
      @response.close
      @server.close_connection self
    end
  end
end
