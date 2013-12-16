require 'spec_helper'

describe Readmill::Client::ClosingRemarks do
  let (:client) { Readmill::Client.new }

  describe '.closing_remark' do
    let (:results) { client.closing_remark(9088) }

    it 'should request a closing_remark from readmill' do
      results
      assert_requested :get, readmill_url('closing_remarks/9088')
    end

    it 'should return a closing_remark' do
      expect(results).to respond_to(:closing_remark)
    end
  end

end
