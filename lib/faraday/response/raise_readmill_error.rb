require 'faraday'
require 'multi_json'

# Internal: Faraday module that the response error middleware is added to.
module Faraday

  # Internal: Faraday Middleware that deals with errors coming back from the API.
  #
  # Examples
  #
  #   connection = Faraday.new({}) do |conn|
  #     conn.use Faraday::Response::RaiseReadmillError
  #   end
  class Response::RaiseReadmillError < Response::Middleware

    # Internal: Hook into the complete callback for the client. When the result
    # comes back, if it is a status code that we want to raise an error for, we
    # will do that.
    #
    # Returns nothing.
    def on_complete(response)
      return if response[:body].nil?

      case response[:body][:status].to_i
      when 400
        raise Readmill::BadRequest, error_message(response)
      when 401
        raise Readmill::Unauthorized, error_message(response)
      when 403
        raise Readmill::Forbidden, error_message(response)
      when 404
        raise Readmill::NotFound, error_message(response)
      when 500
        raise Readmill::InternalServerError, error_message(response)
      when 504
        raise Readmill::GatewayTimeout, error_message(response)
      end
    end

    # Internal: Parse the response and return a human friendly String
    # representing the error that we received.
    #
    # Returns a String.
    def error_message(response)
      method = response[:method].to_s.upcase
      url = response[:url].to_s
      status = response[:body][:status]
      error = response[:body][:error]
      "#{method} #{url}: #{status} - #{error}"
    end
  end

  # Internal: Register this middleware for faraday as response.
  Faraday.register_middleware :response,
    :readmill_errors => lambda { Faraday::Response::RaiseReadmillError }

end
