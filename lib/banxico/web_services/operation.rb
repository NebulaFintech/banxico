module Banxico
  class WebServices::Operation
    attr_reader :client, :operation
  
    def initialize(options={})
      @client = WebServices::WebServiceClient.new(options)
    end

    protected

      def xml_doc(xml_string)
        Nokogiri::XML(xml_string, nil, ENCODING)
      end

      def data_id(data)
        self.class::DATA_SET[data.to_sym][:id]
      end

      def xpath(data_id)
        %Q{bm:DataSet/bm:Series[@IDSERIE="#{data_id}"]/bm:Obs}
      end

      def parsed_response(xml_doc, data_id)
        xml_doc.root.at_xpath(xpath(data_id))
      end
  end
end