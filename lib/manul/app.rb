module Manul
  class App
    def initialize(options)
      @path = options[:path]
    end

    def call(request)
      process request
      [@status, @headers, @content]
    end

    def process(request)
      filepath = File.join @path, request.request_url
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
    ensure
      length = @content.is_a?(String) ? @content.length : @content.stat.size
      @headers = [
        "Content-Length: #{length}"
      ]
    end

  end
end
