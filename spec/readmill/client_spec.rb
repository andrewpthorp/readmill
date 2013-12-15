require 'spec_helper'

describe Readmill::Client do
  let (:client) { Readmill::Client.new }

  describe '.initialize' do
    it 'should pass valid keys to the client' do
      client = Readmill::Client.new(client_id: 'abc123')
      expect(client.client_id).to eq('abc123')
    end

    it 'should override global configurations' do
      client = Readmill::Client.new(timeout: 15)
      expect(client.timeout).to eq(15)
    end

    it 'should not delete unaltered global configurations' do
      client = Readmill::Client.new(timeout: 15)
      expect(client.open_timeout).to eq(10)
    end
  end

  describe '#api_url' do
    it 'should return the correct url' do
      expect(client.api_url).to eq('https://api.readmill.com/v2/')
    end
  end

end
