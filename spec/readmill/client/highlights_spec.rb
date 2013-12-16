require 'spec_helper'

describe Readmill::Client::Highlights do
  let (:client) { Readmill::Client.new }

  describe '.highlights' do
    let (:results) { client.highlights }

    it 'should request all highlights from readmill' do
      results
      assert_requested :get, readmill_url('highlights')
    end

    it 'should return an array of highlights' do
      expect(results).to be_a(Array)
      expect(results.first).to respond_to(:highlight)
    end

    context 'with a reading_id' do
      it 'should request all highlights for the reading' do
        client.highlights(reading_id: 439319)
        assert_requested :get, readmill_url('readings/439319/highlights')
      end
    end

    context 'with a user_id' do
      it 'should request all highlights for the user' do
        client.highlights(user_id: 35202)
        assert_requested :get, readmill_url('users/35202/highlights')
      end
    end

    context 'with a reading_id and a user_id' do
      it 'should raise an argument error' do
        expect { client.highlights(reading_id: 1, user_id: 1) }.to(
          raise_error(ArgumentError, /either reading_id or user_id, but not both/)
        )
      end
    end
  end

  describe '.highlight' do
    let (:results) { client.highlight(827438) }

    it 'should request a highlight from readmill' do
      results
      assert_requested :get, readmill_url('highlights/827438')
    end

    it 'should return a highlight' do
      expect(results).to respond_to(:highlight)
    end

    context 'with comments true' do
      let (:results) { client.highlight(829035, comments: true) }

      it 'should return comments for the highlight from readmill' do
        results
        assert_requested :get, readmill_url('highlights/829035/comments')
      end

      it 'should return an array of comments' do
        expect(results).to be_a(Array)
        expect(results.first).to respond_to(:comment)
      end
    end
  end

end
