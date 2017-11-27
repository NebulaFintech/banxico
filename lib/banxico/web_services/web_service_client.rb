module Banxico
  require 'savon'
  class WebServices::WebServiceClient

    attr_reader :client

    WSDL = "http://www.banxico.org.mx/DgieWSWeb/DgieWS?WSDL"

    def initialize(options={})
      open_timeout = options.fetch(:open_timeout, 5)
      read_timeout = options.fetch(:read_timeout, 5)
      @client = Savon.client(wsdl: WSDL, encoding: ENCODING, open_timeout: open_timeout, read_timeout: read_timeout)
    end

    # def international_reserves
    #   do_request(:reservas_internacionales_banxico)
    # end

    # def interest_rates
    #   do_request(:tasas_de_interes_banxico)
    # end

    # def udis
    #   do_request(:udis_banxico)
    # end

    # def exchange_rates
    #   do_request(:tipos_de_cambio_banxico)
    # end

    def do_request(operation)
      response = client.call(operation)
      response.body
    end
  end
end