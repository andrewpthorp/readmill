require 'spec_helper'

describe Readmill::Client::Periods do
  let (:client) { Readmill::Client.new }

  describe '.periods' do
    let! (:results) { client.periods(443173) }

    it 'should request all periods from readmill' do
      assert_requested :get, readmill_url('readings/443173/periods')
    end

    it 'should return an array of periods' do
      expect(results).to be_a(Array)
      expect(results.first).to respond_to(:period)
    end
  end

end
