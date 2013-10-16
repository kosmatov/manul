module Manul
  class App
    def initialize(options)
      @path = options[:path]
    end

    def call(env)
      process env
      [@status, @headers, @content]
    end

    def process(env)
      check_request_method env[:method]

      filepath = File.join @path, env[:filepath]
      filepath = File.realpath filepath

      if filepath[@path]
        @content = File.open filepath
        @status = 200
      else
        @content = "403 Forbidden\n"
        @status = 403
      end
    rescue Errno::ENOENT => e
      @content = "404 Not Found\n"
      @status = 404
    rescue Exception => e
      @content = "400 Bad Request\n"
      @status = 400
    ensure
      length = @content.is_a?(String) ? @content.length : @content.stat.size
      @headers = [
        "Content-Length: #{length}"
      ]
    end

    def check_request_method(method)
      return if method.upcase == 'GET'
      raise Net::HTTPBadRequest
    end
  end
end
