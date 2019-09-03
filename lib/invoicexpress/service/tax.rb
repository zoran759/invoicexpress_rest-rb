module Invoicexpress
  module Service
    class Tax
      attr_reader :client

      def initialize(client)
        @client = client
      end

      # Returns all your taxes.
      #
      # @option options [Hash]
      #
      # @return [CollectionProxy] An iterator with all your invoices
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      def all(options = {})
        CollectionProxy.new(client, "taxes", "taxes.json", options)
      end

      def find(tax_id)
        json = client.get("taxes/#{tax_id}.json")
        Invoicexpress::Model::Tax.new(json["tax"])
      end

      def update(tax_id, tax)
        json = client.put("taxes/#{tax_id}.json", nil, {tax: tax})
        Invoicexpress::Model::Tax.new(json["tax"])
      end

      def create(tax)
        json = client.post("taxes.json", nil, {tax: tax})
        Invoicexpress::Model::Tax.new(json["tax"])
      end

      def delete(tax_id)
        client.delete("taxes/#{tax_id}.json")
      end

    end
  end
end
