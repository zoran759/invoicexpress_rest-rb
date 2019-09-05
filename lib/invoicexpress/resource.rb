require 'ostruct'

module Invoicexpress
  class Resource < OpenStruct
    def initialize(data)
      super(data)
    end
  end
end
