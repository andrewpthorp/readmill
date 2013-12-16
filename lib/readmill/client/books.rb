module Readmill
  class Client

    # Public: This module will bring all of the methods from the book section
    # of the API.
    module Books

      # Public: Get all books from readmill.
      #
      # opts  - A Hash of options used to modify the results. All of the values
      #         of this Hash will be forwarded to the API as parameters
      #         (default: {}).
      #
      # Returns an Array.
      def books(opts={})
        get('books', opts).items
      end

      # Public: Get a specific book from readmill.
      #
      # id    - The id of a book to get from readmill.
      # opts  - A Hash of options used to modify the results. All of the values
      #         of this Hash will be forwarded to the API as parameters
      #         (default: {}).
      #         :readers  - Boolean whether or not to get readers of a book
      #                     (default: false).
      #
      # Returns a Hashie::Mash.
      def book(id, opts={})
        if opts[:closing_remarks] && opts[:readers]
          raise ArgumentError,
            'You can pass either closing_remarks or readers, but not both.'
        end

        if opts.delete(:closing_remarks)
          get("books/#{id}/closing_remarks", opts).items
        elsif opts.delete(:readers)
          get("books/#{id}/readers", opts).items
        else
          get("books/#{id}", opts)
        end
      end

    end
  end
end
