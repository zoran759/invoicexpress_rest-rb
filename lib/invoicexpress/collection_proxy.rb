module Invoicexpress
  class CollectionProxy

    include Enumerable

    attr_reader :collection_name, :collection_url, :client, :options, :method

    def initialize(client, collection_name, collection_url, options={})
      @client           = client
      @collection_name  = collection_name
      @collection_url   = collection_url
      @options          = options
      @method           = options.delete(:method) || :get
    end

    def each(&block)
      next_page = nil
      loop do
        collection = client.send(method, collection_url, options.merge({page: next_page}))
        collection[collection_name].each do |item_data|
          yield resource_class.new(item_data)
        end
        next_page = get_next_page(collection)
        break if next_page == 0
      end
    end

    def count
      @collection_size ||= collection_size
    end

    private

    def resource_class
      Utils.constantize_resource_name(collection_name)
    end

    def collection_size
      collection = client.send(method, collection_url, options)
      if collection.has_key?("pagination")
        collection['pagination']['total_entries'].to_i
      else
        collection[collection_name].size
      end
    end

    def get_next_page(collection)
      if collection.has_key?("pagination")
        current_page = collection["pagination"]["current_page"].to_i || 1
        next_page = current_page < collection['pagination']['total_pages'].to_i ? current_page + 1 : 0
      else
        next_page = 0
      end
    end

  end
end
