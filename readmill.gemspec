# -*- encoding: utf-8 -*-
require File.expand_path('../lib/readmill/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'readmill'
  s.version     = Readmill::VERSION.dup
  s.platform    = Gem::Platform::RUBY

  s.author      = 'Andrew Thorp'
  s.email       = 'andrewpthorp@gmail.com'
  s.homepage    = 'http://github.com/andrewpthorp/readmill'

  s.summary     = %q{Simple wrapper for the Readmill API.}
  s.description = <<-EOF
    A ruby wrapper for the Readmill Developer API. Their API allows you to get
    all of your Books, Readings, Highlights, Comments, and more. This is a ruby
    wrapper which will allow you to interact with their API with ruby.
  EOF

  s.add_runtime_dependency 'addressable', '~> 2.2'
  s.add_runtime_dependency 'faraday', '~> 0.8'
  s.add_runtime_dependency 'faraday_middleware', '~> 0.8'
  s.add_runtime_dependency 'hashie', '~> 1.2'
  s.add_runtime_dependency 'multi_json', '~> 1.3'
  s.add_runtime_dependency 'oauth', '~> 0.4'

  s.files = %w(LICENSE.md README.md readmill.gemspec)
  s.files += Dir.glob("lib/**/*.rb")
  s.files += Dir.glob("spec/**/*")
  s.test_files    = Dir.glob("spec/**/*")
  s.require_paths = ["lib"]
end
