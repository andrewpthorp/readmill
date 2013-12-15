require 'spec_helper'

describe Readmill::Request do
  let (:client) { Readmill::Client.new }

  describe '#get' do
    it 'should call request' do
      opts = { foo: 'bar' }
      pattern = '/foo/bar'
      client.should_receive(:request).with(:get, pattern, opts)
      client.get(pattern, opts)
    end
  end

end
