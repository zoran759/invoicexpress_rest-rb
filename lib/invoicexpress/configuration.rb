module Invoicexpress
  module Configuration
    VALID_CONNECTION_KEYS = [:endpoint, :user_agent].freeze
    VALID_OPTION_KEYS     = [:account_name, :api_key].freeze
    VALID_CONFIG_KEYS     = VALID_CONNECTION_KEYS + VALID_OPTION_KEYS
    DEFAULT_END_POINT     = 'app.invoicexpress.com'
    DEFAULT_USER_AGENT    = "Mozilla/5.0 (compatible; Invoicexpress Ruby API Client/#{Invoicexpress::VERSION}; +https://github.com/lmmendes/invoicexpress-rest)"

    DEFAULT_API_KEY       = nil

    DEFAULT_ACCOUNT_NAME    = nil

    attr_accessor *VALID_CONFIG_KEYS

    def reset
      self.endpoint   = DEFAULT_END_POINT
      self.api_key    = DEFAULT_API_KEY
      self.user_agent = DEFAULT_USER_AGENT
      self.account_name = DEFAULT_ACCOUNT_NAME
    end

    def options
      Hash[ *VALID_CONFIG_KEYS.map{ |key| [key, send(key)] }.flatten ]
    end


    def configure
      yield self
    end

    def self.extended(base)
      base.reset
    end

  end
end
