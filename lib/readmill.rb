require 'readmill/client'
require 'readmill/configuration'
require 'readmill/error'

module Readmill

  class << self

    # Public: An alias for Readmill::Client.new.
    #
    # Returns an Readmill::Client.
    def new(options={})
      Readmill::Client.new(options)
    end

    # Public: Delegate methods to Readmill::Client.new. If a Readmill::Client
    # does not respond_to? the :method, pass it up the chain.
    #
    # Returns nothing.
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    # Public: Delegate to Readmill::Client.new respond_to?
    #
    # Returns nothing.
    def respond_to?(method, include_private=false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end

  end

end
