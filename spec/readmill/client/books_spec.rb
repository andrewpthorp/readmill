require 'spec_helper'

describe Readmill::Client::Books do
  let (:client) { Readmill::Client.new }

  describe '.books' do
    let! (:result) { client.books }

    it 'should request all books from readmill' do
      assert_requested :get, readmill_url('books')
    end

    it 'should return an array of books' do
      expect(result).to be_a(Array)
      expect(result.first).to respond_to(:book)
    end
  end

  describe '.book' do
    let! (:result) { client.book(1) }

    it 'should request a book from readmill' do
      assert_requested :get, readmill_url('books/1')
    end

    it 'should return a book' do
      expect(result).to respond_to(:book)
    end
  end

end
