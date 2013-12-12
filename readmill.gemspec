# -*- encoding: utf-8 -*-
require File.expand_path('../lib/readmill/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'readmill'
  s.version     = Readmill::VERSION
  s.platform    = Gem::Platform::RUBY

  s.authors     = ['Andrew Thorp']
  s.email       = ['andrewpthorp@gmail.com']
  s.homepage    = 'http://github.com/andrewpthorp/readmill'
  s.description = %q{Simple wrapper for the Readmill API.}
  s.summary     = s.description

  s.add_runtime_dependency 'addressable', '~> 2.2'
  s.add_runtime_dependency 'faraday', '~> 0.8'
  s.add_runtime_dependency 'faraday_middleware', '~> 0.8'
  s.add_runtime_dependency 'hashie', '~> 1.2'
  s.add_runtime_dependency 'multi_json', '~> 1.3'
  s.add_runtime_dependency 'oauth', '~> 0.4'

  s.add_development_dependency 'json'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'markdown'

  s.files         = `git ls-files -cd`.split("\n")
  s.test_files    = Dir.glob("spec/**/*")
  s.require_paths = ["lib"]
end
