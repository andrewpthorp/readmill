module Readmill
  class Client

    # Public: This module will bring all of the methods from the period section
    # of the API.
    module Periods

      # Public: Get periods for a reading from readmill.
      #
      # reading_id  - An id of the reading to get periods for.
      # opts        - A Hash of options used to modify the results. All of the
      #               values of this Hash will be forwarded to the API as
      #               parameters (default: {}).
      #
      # Returns an Array.
      def periods(reading_id, opts={})
        get("readings/#{reading_id}/periods", opts).items
      end

    end
  end
end
