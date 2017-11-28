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

      def set(data)
        self.class::DATA_SET[data.to_sym]
      end

      def banxico_name(data)
        set(data)[:banxico_name]
      end

      def data_id(data)
        set(data)[:id]
      end

      def xpath(data_id)
        %Q{bm:DataSet/bm:Series[@IDSERIE="#{data_id}"]/bm:Obs}
      end

      def parsed_response(xml_doc, data_id, set=nil)
        unless set.nil?
          xml_doc.root.xpath(xpath(data_id), set.to_s)
        else
          xml_doc.root.at_xpath(xpath(data_id))
        end
      end
  end
end