require 'readmill'
require 'rspec'
require 'webmock/rspec'

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:any, /api.readmill.com/)
  end
end

def readmill_url(url)
  "https://api.readmill.com/v2/#{url}"
end
