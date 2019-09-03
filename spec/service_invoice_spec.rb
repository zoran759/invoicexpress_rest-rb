require 'spec_helper'

RSpec.describe Invoicexpress::Service::Invoice do
  before { $client = Invoicexpress::Client.new(account_name: ACCOUNT_NAME, api_key: API_KEY) }
  subject{ Invoicexpress::Service::Invoice.new($client) }

  describe '#create' do
    it 'store a new invoice', :vcr do
      invoice_payload = {
        "date": "07/05/2017",
           "due_date": "08/05/2017",
           "client": {
             "name": "John",
             "code": "100"
           },
           "items": [
               {
                 "name": "Product A",
                 "description": "Cleaning product",
                 "unit_price": "10.0",
                 "quantity": "1.0"
               }
             ]
          }
      clt = subject.create(invoice_payload)
      expect(clt).to be_instance_of(Invoicexpress::Model::Invoice)
    end
  end

end
