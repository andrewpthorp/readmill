require 'spec_helper'

describe Readmill::Client::Books do
  let (:client) { Readmill::Client.new }

  describe '.books' do
    it 'should request all books from readmill' do
      client.books
      assert_requested :get, readmill_url('books')
    end
  end

  describe '.book' do
    it 'should request a book from readmill' do
      client.book(1)
      assert_requested :get, readmill_url('books/1')
    end
  end

end
