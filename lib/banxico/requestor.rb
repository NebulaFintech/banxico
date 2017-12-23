module Banxico
  module Requestor
    class << self
      def series(options)
        if options.fetch(:start_year, nil) || options.fetch(:end_year, nil)
          api_request(options)
        else
          web_service_request(options)
        end
      end

      private

        # Gets historical exchange rate data
        def api_request(options={})
          fail 'Api connection not set!' unless Banxico.configuration.api_connection
          Banxico.configuration.api_connection.series(options)
        end

        # Gets today exchange rates
        def web_service_request(options={})
          fail 'Web Service connection not set!' unless Banxico.configuration.web_service_connection
          Banxico.configuration.web_service_connection.series(options)
        end
    end
  end
end