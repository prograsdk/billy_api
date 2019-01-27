require 'billy_api/version'
require 'billy_api/client'

module BillyApi
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :api_key

    def initialize
      @api_key = nil
    end
  end
end
