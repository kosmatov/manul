# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'manul/version'

Gem::Specification.new do |spec|
  spec.name          = "manul"
  spec.version       = Manul::VERSION
  spec.authors       = ["Konstantin Kosmatov"]
  spec.email         = ["key@kosmatov.ru"]
  spec.description   = %q{Simple web server}
  spec.summary       = %q{Simple web server}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "eventmachine"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "~> 5"
  spec.add_development_dependency "coveralls"
end
