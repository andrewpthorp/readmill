require 'spec_helper'

describe Readmill::Client::Books do
  let (:client) { Readmill::Client.new }

  describe '.books' do
    let (:results) { client.books }

    it 'should request all books from readmill' do
      results
      assert_requested :get, readmill_url('books')
    end

    it 'should return an array of books' do
      expect(results).to be_a(Array)
      expect(results.first).to respond_to(:book)
    end
  end

  describe '.book' do
    let (:results) { client.book(1) }

    it 'should request a book from readmill' do
      results
      assert_requested :get, readmill_url('books/1')
    end

    it 'should return a book' do
      expect(results).to respond_to(:book)
    end

    context 'with closing_remarks true' do
      let (:results) { client.book(1, closing_remarks: true) }

      it 'should request readers for a book from readmill' do
        results
        assert_requested :get, readmill_url('books/1/closing_remarks')
      end

      it 'should return an array of users' do
        expect(results).to be_a(Array)
        expect(results.first).to respond_to(:closing_remark)
      end
    end

    context 'with readers true' do
      let (:results) { client.book(1, readers: true) }

      it 'should request readers for a book from readmill' do
        results
        assert_requested :get, readmill_url('books/1/readers')
      end

      it 'should return an array of users' do
        expect(results).to be_a(Array)
        expect(results.first).to respond_to(:user)
      end
    end

    context 'with closing_remarks true and readers true' do
      let (:results) { client.book(1, closing_remarks: true, readers: true) }
      it 'should raise an argument error' do
        expect { results }.to(
          raise_error(ArgumentError, /closing_remarks or readers, but not both/)
        )
      end
    end
  end

end
