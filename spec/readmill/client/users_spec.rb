require 'spec_helper'

describe Readmill::Client::Users do
  let (:client) { Readmill::Client.new }

  describe '.user' do
    let (:results) { client.user(1) }

    it 'should request a user from readmill' do
      results
      assert_requested :get, readmill_url('users/1')
    end

    it 'should return a user' do
      expect(results).to respond_to(:user)
    end

    context 'with followers true' do
      let (:results) { client.user(1, followers: true) }

      it 'should request all followers for a user' do
        results
        assert_requested :get, readmill_url('users/1/followers')
      end

      it 'should return an array of users' do
        expect(results).to be_a(Array)
        expect(results.first).to respond_to(:user)
      end
    end

    context 'with followings true' do
      let (:results) { client.user(1, followings: true) }

      it 'should request all followings for a user' do
        results
        assert_requested :get, readmill_url('users/1/followings')
      end

      it 'should return an array of users' do
        expect(results).to be_a(Array)
        expect(results.first).to respond_to(:user)
      end
    end

    context 'with followers true and followings true' do
      let (:results) { client.user(1, followers: true, followings: true) }

      it 'should raise an argument error' do
        expect { results }.to(
          raise_error(ArgumentError, /followers or followings, but not both/)
        )
      end
    end
  end

end
