module Banxico
  class WebServices::ExchangeRate < WebServices::Operation

    DATA_SET = {
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

    def initialize(options={})
      super(options)
    end

    def do_historic_request(data, options={})
      response_body = client.do_historic_request(data_id(data), options)
      xml_doc = xml_doc(response_body)
      parsed_response = parsed_response(xml_doc, data_id(data), banxico_name(data))
      parsed_response.map do |xml_node|
        ::Banxico::ExchangeRate.new(data, xml_node)
      end
    end


    def do_wsdl_request(data)
      set_operation(data)
      response_body = client.do_wsdl_request(operation)
      xml_doc = xml_doc(response_body[:"#{operation}_response"][:result])
      parsed_response = parsed_response(xml_doc, data_id(data))
      ::Banxico::ExchangeRate.new(data, parsed_response)
    end

    private

      def set_operation(data)
        @operation = :tipos_de_cambio_banxico
        @operation = :udis_banxico if data.to_sym == :udis
      end
  end
end