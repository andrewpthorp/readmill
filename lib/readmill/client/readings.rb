module Readmill
  class Client

    # Public: This module will bring all of the methods from the reading section
    # of the API.
    module Readings

      # Public: Get all readings from readmill.
      #
      # opts  - A Hash of options used to modify the results. All of the values
      #         of this Hash will be forwarded to the API as parameters
      #         (default: {}).
      #         :book_id - Limit the readings to a specific book.
      #         :user_id - Limit the readings to a specific user.
      #
      # Returns an Array.
      def readings(opts={})
        if !opts[:user_id].nil? && !opts[:book_id].nil?
          raise ArgumentError,
            'You can pass either book_id or user_id, but not both.'
        end

        if !opts[:user_id].nil?
          url = "users/#{opts.delete(:user_id)}/readings"
        elsif !opts[:book_id].nil?
          url = "books/#{opts.delete(:book_id)}/readings"
        else
          url = 'readings'
        end

        get(url, opts).items
      end

      # Public: Get a specific reading from readmill.
      #
      # id    - The id of a reading to get from readmill.
      # opts  - A Hash of options used to modify the results. All of the values
      #         of this Hash will be forwarded to the API as parameters
      #         (default: {}).
      #         :periods    - Boolean whether to get the periods or not
      #                       (default: false).
      #         :locations  - Boolean whether to get the locations or not
      #                       (default: false).
      #
      # Returns a Hashie::Mash.
      def reading(id, opts={})
        if opts[:periods] && opts[:locations]
          raise ArgumentError,
            'You can pass either periods or locations, but not both.'
        end

        if opts.delete(:periods)
          get("readings/#{id}/periods", opts).items
        elsif opts.delete(:locations)
          get("readings/#{id}/locations", opts).items
        else
          get("readings/#{id}", opts)
        end
      end

    end
  end
end
