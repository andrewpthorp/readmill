module Readmill

  class << self
    attr_accessor :configuration
  end

  # Public: Configure a Readmill client.
  #
  # Examples
  #
  #   Readmill.configure do |r|
  #     r.client_id = 'abc123'
  #   end
  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  # Internal: Store all of the configurable options inside of a Configuration
  # class.
  class Configuration

    # Public: An Array of all keys that can be configured. This allows us to
    # set instance keys, knowing what can and cannot be modified.
    VALID_CONFIGURATION_KEYS = [:client_id, :timeout, :open_timeout, :adapter]

    # Internal: Create a get/set method for each valid key.
    attr_accessor *VALID_CONFIGURATION_KEYS

    # Internal: Default all of the keys to valid defaults.
    def initialize
      self.client_id         = nil
      self.timeout           = 10
      self.open_timeout      = 10
      self.adapter           = Faraday.default_adapter
    end

    # Public: Return all of the current values.
    #
    # Returns a Hash.
    def values
      VALID_CONFIGURATION_KEYS.inject({}){|o,k| o.merge!(k => send(k)) }
    end
  end

end
