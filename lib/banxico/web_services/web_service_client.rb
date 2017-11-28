module Banxico
  require 'savon'
  require 'json'
  require 'httparty'
  class WebServices::WebServiceClient

    attr_reader :wsdl_client

    WSDL = "http://www.banxico.org.mx/DgieWSWeb/DgieWS?WSDL"
    HISTORIC_URL = "http://www.banxico.org.mx/SieInternet/consultarDirectorioInternetAction.do?accion=consultarSeries"

    def initialize(options={})
      set_wsdl_client(options)
    end

    def do_historic_request(data_id, options={})
      response = ::HTTParty.post(HISTORIC_URL, headers: historic_request_headers, body: historic_request_body(data_id, options))
      response.body
    end

    def do_wsdl_request(operation)
      response = wsdl_client.call(operation)
      response.body
    end

    private

      def set_wsdl_client(options)
        open_timeout = options.fetch(:open_timeout, 5)
        read_timeout = options.fetch(:read_timeout, 5)
        @wsdl_client = Savon.client(wsdl: WSDL, encoding: ENCODING, open_timeout: open_timeout, read_timeout: read_timeout)
      end

      def historic_request_headers
        {"Content-Type"=>"application/x-www-form-urlencoded"}
      end

      def historic_request_body(series_id, options={})
        {
          idCuadro: "CF102",
          sector: "6",
          version: "2",
          locale: "es",
          "formatoSDMX.x" => "41",
          "formatoSDMX.y" => "8",
          formatoHorizontal: false,
          metadatosWeb: true,
          tipoInformacion: nil,
          anoInicial: options.fetch(:start_year, Time.now.to_date.year),
          anoFinal: options.fetch(:end_year, Time.now.to_date.year),
          series: series_id
        }
      end
  end
end