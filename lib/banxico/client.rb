module Banxico
  module Client
    class << self
      def series(options)
        response = Requestor.series(options)
        exchange_rates = Parser::parse(response, options.fetch(:currency))
        exchange_rates
      end
    end
  end
end