module Readmill
  class Client

    # Public: This module will bring all of the methods from the location
    # section of the API.
    module Locations

      # Public: Get locations for a reading from readmill.
      #
      # reading_id  - An id of the reading to get locations for.
      # opts        - A Hash of options used to modify the results. All of the
      #               values of this Hash will be forwarded to the API as
      #               parameters (default: {}).
      #
      # Returns an Array.
      def locations(reading_id, opts={})
        get("readings/#{reading_id}/locations", opts).items
      end

    end
  end
end
