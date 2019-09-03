module Invoicexpress
  module Service
    class Client
      attr_reader :client

      def initialize(client)
        @client = client
      end

      # Returns a list of all your clients.
      #
      # @option options [Hash]
      #
      # @return [CollectionProxy] An iterator with all your invoices
      # @raise Invoicexpress::Unauthorized When the client is unauthorized
      def all(options = {})
        CollectionProxy.new(client, "clients", "clients.json", options)
      end

      # Creates a new client
      #
      # @param client_payload [Hash] Client information
      #
      # @return [Invoicexpress::Model::Client] Client instance
      # @raise Invoicexpress::Unauthorized The API key or account nameis incorrect
      # @raise Invoicexpress::UnprocessableEntity When some parameters were incorrect.
      def create(client_payload)
        json = client.post("clients.json", nil, {client: client_payload})
        Invoicexpress::Model::Client.new(json["client"])
      end

      # Returns a specific client by ID.
      #
      # @param client_id [Integer] Client ID
      #
      # @return [Invoicexpress::Model::Client] Client instance
      # @raise Invoicexpress::Unauthorized The API key or account nameis incorrect.
      # @raise Invoicexpress::NotFound Client not found.
      # @raise Invoicexpress::UnprocessableEntity When some parameters were incorrect.
      def find(client_id)
        json = client.get("clients/#{client_id}.json")
        Invoicexpress::Model::Client.new(json["client"])
      end

      # Returns a specific client by Name.
      #
      # @param client_name [String] Client name
      #
      # @return [Invoicexpress::Model::Client] Client instance
      # @raise Invoicexpress::Unauthorized The API key or account nameis incorrect
      # @raise Invoicexpress::UnprocessableEntity When some parameters were incorrect.
      def find_by_name(client_name)
        json = client.get("clients/find-by-name.json", {client_name: client_name})
        Invoicexpress::Model::Client.new(json["client"])
      end

      # Returns a specific client by Code.
      #
      # @param client_code [String] Client code
      #
      # @return [Invoicexpress::Model::Client] Client instance
      # @raise Invoicexpress::Unauthorized The API key or account nameis incorrect
      # @raise Invoicexpress::UnprocessableEntity When some parameters were incorrect.
      def find_by_code(client_code)
        json = client.get("clients/find-by-code.json", {client_code: client_code})
        Invoicexpress::Model::Client.new(json["client"])
      end

      def invoices(client_id, options = {})
        CollectionProxy.new(client, "invoices", "clients/#{client_id}/invoices.json", options)
      end
    end
  end
end
