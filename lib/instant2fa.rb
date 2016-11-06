require "active_support"
require "active_support/core_ext"

require "instant2fa/version"
require "instant2fa/configuration"
require "instant2fa/client"

module Instant2FA
  extend self

  def configure
    yield(config)
  end

  def config
    @config ||= Configuration.new
  end

  def new(config=Instant2FA.config.dup, options={})
    Client.new(config, options)
  end

  def client
    @client ||= new(config)
  end

  delegate(*Configuration.public_instance_methods(false), to: :config)
  delegate(*Client.public_instance_methods(false) - [:config], to: :client)
end
