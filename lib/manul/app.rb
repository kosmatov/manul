module Manul
  class App
    def initialize(options)
      @path = options[:path]
      @cgi_path = options[:cgi_path]
      @cgi_alias = options[:cgi_alias]
      @status = 200
    end

    def call(request)
      @request = request
      process
      [@status, @headers, @content]
    end

    def process

      if cgi_file?
        process_cgi
      else
        process_file
      end

    rescue Net::HTTPForbidden => e
      @content = "403 Forbidden\n"
      @status = 403
    rescue Errno::ENOENT => e
      @content = "404 Not Found\n"
      @status = 404
    ensure
      length = @content.is_a?(String) ? @content.length : @content.stat.size
      @headers = [
        "Content-Length: #{length}"
      ]
    end

    private

    def process_file
      filepath = File.join @path, @request.request_url
      filepath = File.realpath filepath

      raise Net::HTTPForbidden unless filepath[@path]

      @content = File.open filepath
    end

    def env
      "REQUEST_URL=#{@request.request_url} COOKIE=#{@request.cookie}"
    end

    def process_cgi
      filepath = File.join @cgi_path, File.sub(@request.request_url, @cgi_alias)
      filepath = File.realpath filepath

      raise Net::HTTPForbidden unless filepath[@cgi_path]

      @content = IO.popen env, filepath
    end

    def cgi_file?
      @request.request_url[@cgi_alias]
    end

  end
end
