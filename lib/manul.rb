require 'http/parser'
require 'eventmachine'
require 'manul/version'

module Manul
  autoload :Server, 'manul/server'
  autoload :Connection, 'manul/connection'
  autoload :App, 'manul/app'
end
