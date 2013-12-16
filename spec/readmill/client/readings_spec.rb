require 'spec_helper'

describe Readmill::Client::Readings do
  let (:client) { Readmill::Client.new }

  describe '.readings' do
    let (:results) { client.readings }

    it 'should request all readings from readmill' do
      results
      assert_requested :get, readmill_url('readings')
    end

    it 'should return an array of readings' do
      expect(results).to be_a(Array)
      expect(results.first).to respond_to(:reading)
    end

    context 'with a book_id' do
      it 'should request all readings for the book' do
        client.readings(book_id: 269082)
        assert_requested :get, readmill_url('books/269082/readings')
      end
    end

    context 'with a user_id' do
      it 'should request all readings for the user' do
        client.readings(user_id: 45146)
        assert_requested :get, readmill_url('users/45146/readings')
      end
    end

    context 'with a book_id and a user_id' do
      it 'should raise an argument error' do
        expect { client.readings(book_id: 1, user_id: 1) }.to(
          raise_error(ArgumentError, /either book_id or user_id, but not both/)
        )
      end
    end
  end

  describe '.reading' do
    let (:results) { client.reading(443173) }

    it 'should request a reading from readmill' do
      results
      assert_requested :get, readmill_url('readings/443173')
    end

    it 'should return a reading' do
      expect(results).to respond_to(:reading)
    end
  end

end
