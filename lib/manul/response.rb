module Manul
  class Response
    attr_accessor :status, :headers, :body

    STATUSES = {
      200 => 'OK',
      400 => 'Bad Request',
      403 => 'Forbidden',
      404 => 'Not Found'
    }

    def head
      "HTTP/1.1 #{status} #{status_string}\r\n#{headers}\r\n\r\n"
    end

    def headers
      headers = [
        "Connection: close",
        "Server: Manul #{Manul::VERSION}"
      ] + @headers.to_a
      headers.join "\r\n"
    end

    def each
      yield head

      if body.respond_to? :each
        body.each { |chunk| yield chunk }
      else
        yield body
      end
    end

    def close
      return unless body
      body.close if body.respond_to? :close
    end

    def status_string
      STATUSES[@status.to_i]
    end
  end
end
