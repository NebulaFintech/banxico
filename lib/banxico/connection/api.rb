module Banxico
  module Connection
    class Api
      require "httparty"
      include ::HTTParty
      base_uri 'http://www.banxico.org.mx'

      def series(options={})
        fail "Invalid currency! Valid currencies are: #{CURRENCIES.keys}" unless CURRENCIES[options.fetch(:currency)].present?
        response = self.class.post(
          "/SieInternet/consultarDirectorioInternetAction.do",
          query: {accion: "consultarSeries"}, headers: self.class.headers, body: self.class.body(options))
        response.body
      end

      private

        class << self
          def headers
            {"Content-Type"=>"application/x-www-form-urlencoded"}
          end

          def body(options={})
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
              series: CURRENCIES[options.fetch(:currency)][:id]
            }
          end
        end
    end
  end
end