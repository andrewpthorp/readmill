module Readmill
  class Client

    module Books

      # Public: Get all books from readmill.
      #
      # Returns an Array.
      def books(opts={})
        get 'books', opts
      end

      # Public: Get a specific book from readmill.
      #
      # id  - The id of a book to get from readmill.
      #
      # Returns a Hashie::Mash.
      def book(id, opts={})
        get "books/#{id}", opts
      end

    end

  end
end
