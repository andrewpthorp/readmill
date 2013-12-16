module Readmill
  class Client

    # Public: This module will bring all of the methods from the closing_remark
    # section of the API.
    module ClosingRemarks

      # Public: Get a specific closing_remark from readmill.
      #
      # id    - The id of a closing_remark to get from readmill.
      # opts  - A Hash of options used to modify the results. All of the values
      #         of this Hash will be forwarded to the API as parameters
      #         (default: {}).
      #
      # Returns a Hashie::Mash.
      def closing_remark(id, opts={})
        get("closing_remarks/#{id}", opts)
      end

    end
  end
end
