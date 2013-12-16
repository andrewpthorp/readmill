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
        ensure_valid_reading_options(opts)

        if opts.delete(:periods)
          get("readings/#{id}/periods", opts).items
        elsif opts.delete(:locations)
          get("readings/#{id}/locations", opts).items
        elsif opts.delete(:highlights)
          get("readings/#{id}/highlights", opts).items
        else
          get("readings/#{id}", opts)
        end
      end


    protected

      # Internal: This method will raise an error if any two of periods,
      # locations, or highlights is true.
      #
      # Raises ArgumentError.
      # Returns nothing.
      def ensure_valid_reading_options(opts)
        if opts.values_at(:periods, :locations, :highlights).grep(true).size > 1
          raise ArgumentError,
            'You can only set one of periods, locations, and highlights.'
        end
      end

    end
  end
end
