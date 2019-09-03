module Invoicexpress
  class Client
    include Request

    attr_accessor *Configuration::VALID_CONFIG_KEYS

    def initialize(options={})
      merge_options = Invoicexpress.options.merge(options)
      Configuration::VALID_CONFIG_KEYS.each do |key|
        self.send("#{key}=", merge_options[key])
      end
      validate_credentials!
    end

    def get(uri='/', params = nil, body = nil, &block)
      request(:get, uri, params, body, &block)
    end

    def post(uri='/', params = nil, body = nil, &block)
      request(:post, uri, params, body, &block)
    end

    def put(uri='/', params=nil, body = nil, &block)
      request(:put, uri, params, body, &block)
    end

    def delete(uri='/', params=nil, body = nil, &block)
      request(:delete, uri, params, body, &block)
    end


    def invoices
      Service::Invoice.new(self)
    end

    def clients
      Service::Client.new(self)
    end

    private
    def validate_credentials!
      error = ConfigurationError.new("`account_name` and `api_key` must not be nil")
      fail error if account_name.nil? || api_key.nil?
    end

  end
end
