module Invoicexpress
  module Service
    class Sequence
      attr_reader :client

      def initialize(client)
        @client = client
      end

      # Returns all your sequences
      #
      # @option options [Hash]
      #
      # @return [CollectionProxy] An iterator with all your invoices
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      def all(options = {})
        #client.request(:get, '/invoices.json', options)
        CollectionProxy.new(client, "sequences", "sequences.json", options)
      end

      # Returns a specific invoice
      #
      # @param document_id [String] Id of the invoice to get
      # @option document_type [String] Invoice document type invoices, simplified_invoices
      #
      # @return [CollectionProxy] An iterator with all your invoices
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      def find(document_id)
        result = client.get("sequences/#{document_id}.json")
        Invoicexpress::Model::Sequence.new(result["sequence"])
      end

      # Creates a new sequence
      #
      # @param params [Hash] Id of the invoice to get
      #
      # @return [CollectionProxy] An iterator with all your invoices
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::NotAcceptable The document_id provided is in an invalid state.
      def create(params = {})
        json = client.post("sequences.json", nil, {sequence: params})
        Invoicexpress::Model::Sequence.new(json["sequence"])
      end
    end
  end
end
