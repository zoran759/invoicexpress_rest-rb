require 'spec_helper'

RSpec.describe Invoicexpress::Service::Invoice do
  before { $client = Invoicexpress::Client.new(account_name: ACCOUNT_NAME, api_key: API_KEY) }
  subject{ Invoicexpress::Service::Invoice.new($client) }

  describe "#all" do
    it "should return a CollectionProxy" do
      expect(subject.all).to be_instance_of(Invoicexpress::CollectionProxy)
    end

    it "CollectionProxy#collection_url should return 'invoices.json' string" do
      expect(subject.all.collection_url).to eq("invoices.json")
    end

    it "CollectionProxy#client should return a Invoicexpress::Client object" do
      expect(subject.all.client).to eq($client)
    end

    it "CollectionProxy#collection_name should return 'invoices' string" do
      expect(subject.all.collection_name).to eq("invoices")
    end
  end


  describe '#create' do
    it 'store a new invoice', :vcr do
      invoice_data = "07/05/2017"
      invoice_due_date = "08/05/2017"
      unit_price = 10.0

      invoice_payload = {
        "date": invoice_data,
        "due_date": invoice_due_date,
        "client": {
          "name": "John",
          "code": "100"
        },
        "items": [
         {
           "name": "Product A",
           "description": "Cleaning product",
           "unit_price": unit_price,
           "quantity": "1.0"
         }
        ]
      }
      clt = subject.create(invoice_payload)
      expect(clt).to be_instance_of(Invoicexpress::Model::Invoice)
      expect(clt.id).to be > 0
      expect(clt.type).to eq("Invoice")
      expect(clt.sequence_number).to eq("rascunho")
      expect(clt.date).to eq(invoice_data)
      expect(clt.due_date).to eq(invoice_due_date)
      expect(clt.sum).to eq(10.0)
    end

    it 'store a new simplified_invoice', :vcr do
      invoice_data = "07/05/2017"
      invoice_due_date = "08/05/2017"
      unit_price = 10.0

      invoice_payload = {
        "date": invoice_data,
        "due_date": invoice_due_date,
        "client": {
          "name": "John",
          "code": "100"
        },
        "items": [
         {
           "name": "Product A",
           "description": "Cleaning product",
           "unit_price": unit_price,
           "quantity": "1.0"
         }
        ]
      }
      clt = subject.create(invoice_payload, :simplified_invoice)
      expect(clt).to be_instance_of(Invoicexpress::Model::SimplifiedInvoice)
      expect(clt.id).to be > 0
      expect(clt.type).to eq("SimplifiedInvoice")
      expect(clt.status).to eq("draft")
      expect(clt.sequence_number).to eq("rascunho")
      expect(clt.date).to eq(invoice_data)
      expect(clt.due_date).to eq(invoice_due_date)
      expect(clt.sum).to eq(10.0)
    end

    it 'store a new invoice_receipt', :vcr do
      invoice_data = "07/05/2017"
      invoice_due_date = "08/05/2017"
      unit_price = 10.0

      invoice_payload = {
        "date": invoice_data,
        "due_date": invoice_due_date,
        "client": {
          "name": "John",
          "code": "100"
        },
        "items": [
         {
           "name": "Product A",
           "description": "Cleaning product",
           "unit_price": unit_price,
           "quantity": "1.0"
         }
        ]
      }
      clt = subject.create(invoice_payload, :invoice_receipt)
      expect(clt).to be_instance_of(Invoicexpress::Model::InvoiceReceipt)
      expect(clt.id).to be > 0
      expect(clt.type).to eq("InvoiceReceipt")
      expect(clt.status).to eq("draft")
      expect(clt.sequence_number).to eq("rascunho")
      expect(clt.date).to eq(invoice_data)
      expect(clt.due_date).to eq(invoice_due_date)
      expect(clt.sum).to eq(10.0)
    end
  end

end
