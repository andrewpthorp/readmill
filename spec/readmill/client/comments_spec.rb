require 'spec_helper'

describe Readmill::Client::Comments do
  let (:client) { Readmill::Client.new }

  describe '.comments' do
    let (:results) { client.comments(829035) }

    it 'should request all comments from readmill' do
      results
      assert_requested :get, readmill_url('highlights/829035/comments')
    end

    it 'should return an array of comments' do
      expect(results).to be_a(Array)
      expect(results.first).to respond_to(:comment)
    end
  end

  describe '.comment' do
    let (:results) { client.comment(112631) }

    it 'should request a comment from readmill' do
      results
      assert_requested :get, readmill_url('comments/112631')
    end

    it 'should return a comment' do
      expect(results).to respond_to(:comment)
    end
  end

end
