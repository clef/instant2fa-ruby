require "instant2fa/resources"

module Instant2FA
  class Configuration
    attr_accessor :access_key
    attr_accessor :access_secret
    attr_accessor :api_base
    attr_accessor :debug

    def initialize
      @api_base = 'https://api.instant2fa.com/'
    end

    def debug?
      @debug
    end
  end
end
