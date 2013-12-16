module Readmill
  class Client

    # Public: This module will bring all of the methods from the comment
    # section of the API.
    module Comments

      # Public: Get all comments from readmill.
      #
      # highlight_id  - An id of a highlight to get comments for.
      # opts          - A Hash of options used to modify the results. All of the
      #                 values of this Hash will be forwarded to the API as
      #                 parameters (default: {}).
      #
      # Returns an Array.
      def comments(highlight_id, opts={})
        get("highlights/#{highlight_id}/comments", opts).items
      end

      # Public: Get a specific comment from readmill.
      #
      # id    - The id of a comment to get from readmill.
      # opts  - A Hash of options used to modify the results. All of the values
      #         of this Hash will be forwarded to the API as parameters
      #         (default: {}).
      #
      # Returns a Hashie::Mash.
      def comment(id, opts={})
        get("comments/#{id}", opts)
      end

    end
  end
end
