require 'readmill/request'
require 'readmill/configuration'
require 'readmill/client/books'
require 'readmill/client/locations'
require 'readmill/client/periods'
require 'readmill/client/readings'

module Readmill

  # Public: The Client is what wraps all of the Readmill API. You will use this
  # class to handle the majority of your interaction with Readmill.
  class Client

    # Public: Set instance level configuration values.
    attr_accessor *Readmill::Configuration::VALID_CONFIGURATION_KEYS

    # Public: Constructor for a Readmill::Client.
    #
    # opts - A Hash of options to modify the client (default: {}).
    def initialize(opts={})

      # TODO: Extract this, move it elsewhere. If this hasn't been configured,
      # I'm wondering if we raise an exception and move on?
      Readmill.configuration ||= Readmill::Configuration.new

      config = Readmill.configuration.values.merge(opts)
      Readmill::Configuration::VALID_CONFIGURATION_KEYS.each do |k|
        send("#{k}=", config[k])
      end
    end

    # Public: Get the base URL for accessing the Readmill API.
    #
    # Returns a String.
    def api_url
      "https://api.readmill.com/v2/"
    end

    include Readmill::Request
    include Readmill::Client::Books
    include Readmill::Client::Locations
    include Readmill::Client::Periods
    include Readmill::Client::Readings

  end

end
