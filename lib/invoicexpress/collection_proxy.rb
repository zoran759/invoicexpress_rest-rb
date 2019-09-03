module Invoicexpress
  class CollectionProxy

    include Enumerable

    attr_reader :collection_name, :collection_url, :client, :options

    def initialize(client, collection_name, collection_url, params={})
      @client           = client
      @collection_name  = collection_name
      @collection_url   = collection_url
      @options          = options
    end

    def each(&block)
      next_page = nil
      loop do
        if next_page
          collection = client.get(collection_url, options.merge({page: next_page}))
        else
          collection = client.get(collection_url, options)
        end
        collection[collection_name].each do |item_data|
          yield resource_class.new(item_data)
        end
        # Kaminari returns next_page as an empty string if there aren't more pages
        if supports_pagination?
          current_page = collection["pagination"]["current_page"].to_i || 1
          next_page = current_page < collection['pagination']['total_pages'].to_i ? current_page + 1 : 0
        else
          next_page = 0
        end
        break if next_page == 0
      end
      self
    end

    def count
      @collection_size ||= collection_size
    end

    private

      def resource_class
        Utils.constantize_resource_name(collection_name)
      end

      def collection_size
        collection = client.get(collection_url, options)
        if supports_pagination?
          collection['pagination']['total_entries'].to_i
        else
          collection[collection_name].size
        end
      end

      def supports_pagination?
        !%w[taxes].include?(collection_name)
      end

  end
end
