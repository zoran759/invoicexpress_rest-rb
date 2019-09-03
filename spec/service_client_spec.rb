require 'spec_helper'

RSpec.describe Invoicexpress::Service::Client do
  before { $client = Invoicexpress::Client.new(account_name: ACCOUNT_NAME, api_key: API_KEY) }
  subject{ Invoicexpress::Service::Client.new($client) }

  describe "#all" do
    it "should return a CollectionProxy" do
      expect(subject.all).to be_instance_of(Invoicexpress::CollectionProxy)
    end

    it "CollectionProxy#collection_url should return 'clients.json' string" do
      expect(subject.all.collection_url).to eq("clients.json")
    end

    it "CollectionProxy#client should return a Invoicexpress::Client object" do
      expect(subject.all.client).to eq($client)
    end

    it "CollectionProxy#collection_name should return 'clients' string" do
      expect(subject.all.collection_name).to eq("clients")
    end

    it "CollectionProxy#first", :vcr do
      expect(subject.all.count).to eq(7)
    end
  end

  describe '#create' do
    it 'store a new client', :vcr do
      client_payload = {
        "name": "Client Name",
        "code": "12345",
        "email": "foo@bar.com",
        "language": "pt",
        "address": "Avenida da República, Lisboa",
        "city": "Lisboa",
        "postal_code": "1050-555",
        "country": "Portugal",
        "fiscal_id": "508025338",
        "website": "www.invoicexpress.com",
        "phone": "213456789",
        "fax": "213456788",
        "preferred_contact": {
          "name": "Bruce Norris",
          "email": "email@invoicexpress.com",
          "phone": "213456789"
        },
        "observations": "Observations",
        "send_options": "1"
      }
      clt = subject.create(client_payload)
      expect(clt).to be_instance_of(Invoicexpress::Model::Client)
    end

    it 'fail trying to create a new client', :vcr do
      client_payload = {} # client "name" and "code" are required parameters
      expect{ subject.create(client_payload) }.to raise_error(Invoicexpress::UnprocessableEntity)
    end
  end

  describe "#find" do
    it "fetch existing client record", :vcr do
      client_id = 6212263
      clt = subject.find(client_id)
      expect(clt).to be_instance_of(Invoicexpress::Model::Client)
      expect(clt.id).to eq(client_id)
    end

    it "client record not found", :vcr do
      client_id = 0
      expect{ subject.find(client_id) }.to raise_error(Invoicexpress::NotFound)
    end
  end

  describe "#find_by_name" do
    it "fetch client by name", :vcr do
      client_name = "Client Name"
      clt = subject.find_by_name(client_name)
      expect(clt).to be_instance_of(Invoicexpress::Model::Client)
      expect(clt.name).to eq(client_name)
      expect(clt.id).not_to eq(0)
    end
  end

  describe "#find_by_code" do
    it "fetch client by code", :vcr do
      client_code = "12345"
      clt = subject.find_by_code(client_code)
      expect(clt).to be_instance_of(Invoicexpress::Model::Client)
      expect(clt.code).to eq(client_code)
      expect(clt.id).not_to eq(0)
    end
  end

  describe "#invoices" do
    it "fetch client invoices from client id (integer)", :vcr do
      client_id = 6206313
      expect(subject.invoices(client_id)).to be_instance_of(Invoicexpress::CollectionProxy)
    end

    it "fetch invoices for unexisting client (client id=0)", :vcr do
      client_id = 0
      collection = subject.invoices(client_id)
      expect{ collection.count }.to raise_error(Invoicexpress::NotFound)
    end
  end

end
