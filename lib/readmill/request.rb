require 'multi_json'
require 'faraday_middleware'
require 'faraday/response/raise_readmill_error'

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

        unless client_id.nil?
          request.headers['Authorization'] = "Client #{client_id}"
        end
      end

      response.body
    end

    # Internal: Build a new instance of Faraday with some default options and
    # return it.
    #
    # Returns a Faraday::Connection.
    def connection
      options = { url: api_url, ssl: { verify: false } }

      connection = Faraday.new(options) do |conn|
        conn.response :readmill_errors
        conn.response :mashify
        conn.response :json

        conn.adapter  adapter
      end

      connection
    end

  end

end
