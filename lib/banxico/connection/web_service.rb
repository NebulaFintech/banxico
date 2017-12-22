module Banxico
  module Connection
    class WebService
      require 'savon'
      ENCODING = 'ISO-8859-1'
      WSDL = 'http://www.banxico.org.mx/DgieWSWeb/DgieWS?WSDL'

      attr_reader :connection

      def initialize(options={})
        @connection = Savon.client(wsdl: WSDL, encoding: ENCODING, open_timeout: options.fetch(:open_timeout), read_timeout: options.fetch(:read_timeout))
      end

      def series(options={})
        fail "Invalid currency! Valid currencies are: #{CURRENCIES.keys}" unless CURRENCIES.keys.include?(options.fetch(:currency))
        operation = :tipos_de_cambio_banxico
        operation = :udis_banxico if options.fetch(:currency).to_sym == :udis
        response = connection.call(operation)
        response.body[:"#{operation}_response"][:result]
      end
    end
  end
end