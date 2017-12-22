require 'banxico/version'
require 'banxico/exchange_rate'
require 'banxico/client'
require 'banxico/connection/api'
require 'banxico/connection/web_service'
require 'banxico/requestor'
require 'banxico/parser'

module Banxico
  require 'active_support'
  require 'active_support/core_ext'

  CURRENCIES = {
    usd: {
      id: "SF60653",
      description: "MXN vs USD FIX",
      banxico_name: :dolar_fix
    },
    udis: {
      id: "SP68257",
      description: "MXN vs UDIS",
      banxico_name: :udis
    }
  }.freeze

  class << self
    attr_reader :configuration
  end

  def self.configure
    yield(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  class Configuration
    attr_accessor :web_service_connection, :api_connection

    def initialize
      @web_service_connection = Connection::WebService.new({open_timeout: 5, read_timeout: 5})
      @api_connection = Connection::Api.new
    end
  end
end
