module Banxico
  class ExchangeRate
    attr_reader :currency, :date, :value
    def initialize(currency, xml)
      @currency = currency.to_sym
      @date = Date.iso8601(xml[:TIME_PERIOD])
      @value = xml[:OBS_VALUE].to_f
    end
  end
end