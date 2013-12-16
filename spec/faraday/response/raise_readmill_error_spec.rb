require 'spec_helper'

describe Faraday::Response::RaiseReadmillError do
  before do
    @class = described_class.new
  end

  context 'when used' do
    before do
      @response = Hashie::Mash.new(method: :get, url: 'http://test')
      @response.body = Hashie::Mash.new(status: 'error', error: 'foobar')
    end

    it 'does not raise an error if the response has no body' do
      @response.body = nil
      lambda {
        @class.on_complete(@response)
      }.should_not raise_error
    end

    it 'does not raise an error for HTTP 200' do
      @response.body.status = 200
      lambda {
        @class.on_complete(@response)
      }.should_not raise_error
    end

    it 'raises an error for HTTP 400' do
      @response.body.status = 400
      lambda {
        @class.on_complete(@response)
      }.should raise_error(Readmill::BadRequest)
    end

    it 'raises an error for HTTP 401' do
      @response.body.status = 401
      lambda {
        @class.on_complete(@response)
      }.should raise_error(Readmill::Unauthorized)
    end

    it 'raises an error for HTTP 403' do
      @response.body.status = 403
      lambda {
        @class.on_complete(@response)
      }.should raise_error(Readmill::Forbidden)
    end

    it 'raises an error for HTTP 404' do
      @response.body.status = 404
      lambda {
        @class.on_complete(@response)
      }.should raise_error(Readmill::NotFound)
    end

    it 'raises an error for HTTP 500' do
      @response.body.status = 500
      lambda {
        @class.on_complete(@response)
      }.should raise_error(Readmill::InternalServerError)
    end

    it 'raises an error fro HTTP 504' do
      @response.body.status = 504
      lambda {
        @class.on_complete(@response)
      }.should raise_error(Readmill::GatewayTimeout)
    end
  end

  describe '#error_message' do
    it 'should be formatted correctly' do
      response = Hashie::Mash.new(method: :get, url: 'http://test')
      response.body = Hashie::Mash.new(status: '404', error: 'Not Found')
      result = @class.error_message(response)
      result.should eq('GET http://test: 404 - Not Found')
    end
  end

end
