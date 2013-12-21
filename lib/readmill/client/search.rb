module Readmill
  class Client

    # Public: This module will bring all of the methods from the search section
    # of the API.
    module Search

      # Public: Search the readmill API for books, highlights, etc.
      #
      # query - A String to search the API for.
      # opts  - A Hash of options used to modify the results. All of the values
      #         of this Hash will be forwarded to the API as parameters
      #         (default: {}).
      #
      # Returns a Hashie::Mash.
      def search(query, opts={})
        ensure_valid_search_options(opts)

        opts[:query] = query
        if opts.delete(:books)
          url = 'books/search'
        elsif opts.delete(:highlights)
          url = 'highlights/search'
        elsif opts.delete(:users)
          url = 'users/search'
        else
          url = 'search'
        end

        get(url, opts).items
      end

    protected

      # Internal: This method will raise an error if any two of books,
      # highlights, or users is true.
      #
      # Raises ArgumentError.
      # Returns nothing.
      def ensure_valid_search_options(opts)
        if opts.values_at(:books, :highlights, :users).grep(true).size > 1
          raise ArgumentError,
            'You can only set one of books, highlights, and users.'
        end
      end

    end
  end
end
