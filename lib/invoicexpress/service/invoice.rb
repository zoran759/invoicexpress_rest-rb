module Invoicexpress
  module Service
    class Invoice
      DOCUMENT_TYPES = %w[
        invoice simplified_invoice invoice_receipt
        vat_moss_invoice credit_note debit_note
      ].freeze

      attr_reader :client

      def initialize(client)
        @client = client
      end

      # Returns all your invoices
      #
      # @option options [Hash]
      #
      # @return [CollectionProxy] An iterator with all your invoices
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      def all(options = {})
        #client.request(:get, '/invoices.json', options)
        CollectionProxy.new(client, "invoices", "invoices.json", options)
      end

      # def create(hash, document_type: 'invoices')
      #   raise "Invalid dockement type `#{{document_type}}` expected one of #{DOCUMENT_TYPES}" unless DOCUMENT_TYPES.include?(document_type)
      #   client.post("#{document_type}.json", payload: hash)
      # end

      # Returns a specific invoice
      #
      # @param document_id [String] Id of the invoice to get
      # @option document_type [String] Invoice document type invoices, simplified_invoices
      #
      # @return [CollectionProxy] An iterator with all your invoices
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      def find(document_id, document_type: 'invoices')
        client.get("#{document_type}/#{document_id}.json")
      end

      # Returns the url of the PDF for the specified document.
      # This is an asynchronous operation, which means the PDF file may not be ready immediately.
      #
      # @param document_id [String] Id of the invoice to get
      # @option document_type [String] Invoice document type invoices, simplified_invoices
      #
      # @return [CollectionProxy] An iterator with all your invoices
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::NotAcceptable The document_id provided is in an invalid state.
      def create_pdf(document_id, options = {})
        client.get("api/pdf/#{document_id}.json", options)
      end

      # Creates a new invoice, simplified_invoice, invoice_receipt, credit_note, debit_note
      # This is an asynchronous operation, which means the PDF file may not be ready immediately.
      #
      # @param document_id [String] Id of the invoice to get
      # @option document_type [String] Invoice document type invoices, simplified_invoices
      #
      # @return [CollectionProxy] An iterator with all your invoices
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      # @raise Invoicexpress::NotAcceptable The document_id provided is in an invalid state.
      def create(params = {}, document_type = :invoice)
        raise ArgumentError.new("Invalid document_type `#{document_type}` expected on of #{DOCUMENT_TYPES.join(', ')}") unless DOCUMENT_TYPES.include?(document_type.to_s)
        json = client.post("#{document_type}s.json", nil, {invoice: params})
        klass = Utils.constantize_singular_resource_name(document_type.to_s)
        klass.new(json[document_type.to_s])
      end

      def update(document_id, document_type = 'invoice', state)
        json = client.put("/purchase_orders/#{document_type}/#{document_id}.json")
        Invoicexpress::Model::Invoice.new(json["invoice"])
      end

    end
  end
end
