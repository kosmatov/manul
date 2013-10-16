module Manul
  class Request
    attr_reader :env

    def initialize
      @env = {}
    end

    def parse(data)
      head = data.split("\r\n").first.split

      @env = {
        method: head[0],
        filepath: URI::decode(head[1].to_s),
        proto: head[2]
      }

      p head.join ' '
    end
  end
end
