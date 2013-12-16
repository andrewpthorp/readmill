module Readmill
  class Client

    # Public: This module will bring all of the methods from the highlight
    # section of the API.
    module Highlights

      # Public: Get all highlights from readmill.
      #
      # opts  - A Hash of options used to modify the results. All of the values
      #         of this Hash will be forwarded to the API as parameters
      #         (default: {}).
      #         :reading_id - Limit the highlights to a specific reading.
      #         :user_id - Limit the highlights to a specific user.
      #
      # Returns an Array.
      def highlights(opts={})
        if !opts[:user_id].nil? && !opts[:reading_id].nil?
          raise ArgumentError,
            'You can pass either reading_id or user_id, but not both.'
        end

        if !opts[:user_id].nil?
          url = "users/#{opts.delete(:user_id)}/highlights"
        elsif !opts[:reading_id].nil?
          url = "readings/#{opts.delete(:reading_id)}/highlights"
        else
          url = 'highlights'
        end

        get(url, opts).items
      end

      # Public: Get a specific highlight from readmill.
      #
      # id    - The id of a highlight to get from readmill.
      # opts  - A Hash of options used to modify the results. All of the values
      #         of this Hash will be forwarded to the API as parameters
      #         (default: {}).
      #
      # Returns a Hashie::Mash.
      def highlight(id, opts={})
        get("highlights/#{id}", opts)
      end

    end
  end
end
