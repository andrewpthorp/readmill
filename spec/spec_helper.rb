require 'readmill'
require 'rspec'
require 'webmock/rspec'
require 'hashie'
require 'vcr'
require 'dotenv'

# Monkeypatch String to add the underscore method
class String
  def underscore
    self.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
      .gsub(/([a-z\d])([A-Z])/,'\1_\2').tr("-", "_").downcase
  end
end

# Load all ENV variables from .env
Dotenv.load

Readmill.configure do |c|
  c.client_id = ENV['READMILL_CLIENT_ID']
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.filter_sensitive_data('READMILL_CLIENT_ID') { ENV['READMILL_CLIENT_ID'] }
  c.hook_into :webmock
end

RSpec.configure do |config|

  # Add VCR to all tests
  config.around(:each) do |example|
    options = example.metadata[:vcr] || {}
    if options[:record] == :skip
      VCR.turned_off(&example)
    else
      name = example.metadata[:full_description].split(/\s+/, 2).join("/")
        .underscore.gsub(/[^\w\/]+/, "_")
      VCR.use_cassette(name, options, &example)
    end
  end
end

def readmill_url(url)
  "https://api.readmill.com/v2/#{url}"
end
