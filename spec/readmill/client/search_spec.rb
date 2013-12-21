require 'spec_helper'

describe Readmill::Client::Readings do
  let (:client) { Readmill::Client.new }

  describe '.search' do
    let (:results) { client.search('Steve jobs') }

    it 'should request a search from readmill' do
      results
      assert_requested :get, readmill_url('search?query=Steve%20jobs')
    end

    it 'should return some items' do
      expect(results).not_to be_empty
    end

    context 'with books true' do
      let (:results) { client.search('Steve jobs', books: true) }

      it 'should search books from readmill' do
        results
        assert_requested :get, readmill_url('books/search?query=Steve%20jobs')
      end

      it 'should return an array of books' do
        expect(results).to be_a(Array)
        expect(results.first).to respond_to(:book)
      end
    end

    context 'with highlights true' do
      let (:results) { client.search('Steve jobs', highlights: true) }

      it 'should search highlights readmill' do
        results
        assert_requested :get, readmill_url('highlights/search?query=Steve%20jobs')
      end

      it 'should return an array of highlights' do
        expect(results).to be_a(Array)
        expect(results.first).to respond_to(:highlight)
      end
    end

    context 'with users true' do
      let (:results) { client.search('Andrew Thorp', users: true) }

      it 'should search users from readmill' do
        results
        assert_requested :get, readmill_url('users/search?query=Andrew%20Thorp')
      end

      it 'should return an array of users' do
        expect(results).to be_a(Array)
        expect(results.first).to respond_to(:user)
      end
    end

    [
      { books: true, highlights: true, users: false },
      { books: true, highlights: false, users: true },
      { books: false, highlights: true, users: true }
    ].each do |opts|
      context "with books #{opts[:books]}, highlights #{opts[:highlights]}, and users #{opts[:users]}" do
        it 'should raise an argument error' do
          expect { client.search('Andrew',  books: opts[:books],
                                            highlights: opts[:highlights],
                                            users: opts[:users]) }.to(
            raise_error(ArgumentError, /You can only set one of books, highlights, and users/)
          )
        end
      end
    end
  end

end
