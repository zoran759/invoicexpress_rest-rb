require 'faraday'

require "invoicexpress/version"
require "invoicexpress/exception"
require "invoicexpress/request"
require "invoicexpress/configuration"
require "invoicexpress/utils"
require "invoicexpress/collection_proxy"
require "invoicexpress/client"
require "invoicexpress/service/invoice"
require "invoicexpress/service/client"
require "invoicexpress/service/tax"

require "invoicexpress/resource"
require "invoicexpress/model/invoice_item"
require "invoicexpress/model/invoice"
require "invoicexpress/model/client"
require "invoicexpress/model/tax"

module Invoicexpress
  extend Configuration

  def self.new(options = {})
    Client.new(options)
  end

end
