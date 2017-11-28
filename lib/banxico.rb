require 'banxico/version'
require 'banxico/exchange_rate'
require 'banxico/web_services/web_services'
require 'banxico/web_services/operation'
require 'banxico/web_services/exchange_rate'
require 'banxico/web_services/web_service_client'

module Banxico
  ENCODING = "ISO-8859-1"

  # client = Banxico::WebServices::ExchangeRate.new
  # exchange_rate = client.do_wsdl_request(:usd)
  # exchange_rate.currency
  # exchange_rate.date
  # exchange_rate.value
end
