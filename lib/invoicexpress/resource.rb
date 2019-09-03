require 'ostruct'

module Invoicexpress
  class Resource < OpenStruct

    attr_reader :collection_name, :client

    # def initialize(client, collection_name,data)
    #   @client          = client
    #   @collection_name = collection_name
    #   super(data)
    # end

    def initialize(data)
      super(data)
    end


  end
end
