module Readmill
  class Client

    # Public: This module will bring all of the methods from the user
    # section of the API.
    module Users

      # Public: Get a specific user from readmill.
      #
      # id    - The id of a user to get from readmill.
      # opts  - A Hash of options used to modify the results. All of the values
      #         of this Hash will be forwarded to the API as parameters
      #         (default: {}).
      #
      # Returns a Hashie::Mash.
      def user(id, opts={})
        if opts[:followers] && opts[:followings]
          raise ArgumentError,
            'You can pass either followers or followings, but not both.'
        end

        if opts.delete(:followers)
          get("users/#{id}/followers", opts).items
        elsif opts.delete(:followings)
          get("users/#{id}/followings", opts).items
        else
          get("users/#{id}", opts)
        end
      end

    end
  end
end
