module Manul
  class Request
    attr_reader :env

    def initialize
      @env = {}
    end

    def parse(data)
      head = data.split("\r\n").first
      p head
      @env[:filepath] = URI::decode head.split[1].to_s
    end
  end
end
