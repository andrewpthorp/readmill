require 'multi_json'
require 'faraday_middleware'

module Readmill

  module Request

    # Public: Make an HTTP GET Request to the path, passing the opts as params
    # in the query.
    #
    # path    - The path to request.
    # opts    - A Hash to send as query parameters (default: {}).
    #
    # Returns a String.
    def get(path, opts={})
      request(:get, path, opts)
    end

    private

    # Internal: Use the Faraday::Connection from lib/espn/connection.rb and
    # make the HTTP Request to the path.
    #
    # method  - A Symbol specifying the HTTP method to use.
    # path    - The URL to send the request to.
    # opts    - The Hash options to send as query parameters.
    #
    # Returns a String.
    def request(method, path, opts)
      response = connection.send(method) do |request|
        request.url(path, opts)
        request.options[:timeout] = timeout
        request.options[:open_timeout] = open_timeout
      end

      response.body
    end

    # Internal: Build a new instance of Faraday with some default options and
    # return it.
    #
    # Returns a Faraday::Connection.
    def connection
      options = { url: api_url, ssl: { verify: false } }
      options.merge!(params: { client_id: client_id }) unless client_id.nil?

      connection = Faraday.new(options) do |builder|
        builder.use FaradayMiddleware::Mashify
        builder.use FaradayMiddleware::ParseJson
        builder.adapter adapter
      end

      connection
    end

  end

end
