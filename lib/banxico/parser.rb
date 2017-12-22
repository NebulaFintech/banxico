 module Banxico 
  module Parser
    class << self
      def parse(response, currency)
        xml_doc = xml_doc(response)
        currency_hash = CURRENCIES[currency]
        elements = get_elements(xml_doc, currency_hash[:id], currency_hash[:banxico_name])
        elements.map do |element|
          ExchangeRate.new(currency, element)
        end
      end

      private

        def xml_doc(xml_string)
          Nokogiri::XML(xml_string, nil)
        end

        def set(data)
          self.class::DATA_SET[data.to_sym]
        end

        def data_id(data)
          set(data)[:id]
        end

        def xpath(data_id)
          %Q{bm:DataSet/bm:Series[@IDSERIE="#{data_id}"]/bm:Obs}
        end

        def get_elements(xml_doc, data_id, set=nil)
          unless set.nil?
            xml_doc.root.xpath(xpath(data_id), set.to_s)
          else
            xml_doc.root.at_xpath(xpath(data_id))
          end
        end
    end
  end
end