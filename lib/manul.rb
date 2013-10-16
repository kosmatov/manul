require 'eventmachine'
require 'manul/version'

module Manul
  autoload :Server, 'manul/server'
  autoload :Connection, 'manul/connection'
  autoload :App, 'manul/app'
  autoload :Request, 'manul/request'
  autoload :Response, 'manul/response'
end
