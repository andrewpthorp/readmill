require 'spec_helper'

describe Readmill::Client::Locations do
  let (:client) { Readmill::Client.new }

  describe '.locations' do
    let! (:results) { client.locations(443173) }

    it 'should request all locations from readmill' do
      assert_requested :get, readmill_url('readings/443173/locations')
    end

    it 'should return an array of locations' do
      expect(results).to be_a(Array)
      expect(results.first).to respond_to(:location)
    end
  end

end
