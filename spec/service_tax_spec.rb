require 'spec_helper'

RSpec.describe Invoicexpress::Service::Tax do
  before { $client = Invoicexpress::Client.new(account_name: ACCOUNT_NAME, api_key: API_KEY) }
  subject{ Invoicexpress::Service::Tax.new($client) }

  describe "#all" do
    it "should return a CollectionProxy" do
      expect(subject.all).to be_instance_of(Invoicexpress::CollectionProxy)
    end

    it "CollectionProxy#collection_url should return 'taxes.json' string" do
      expect(subject.all.collection_url).to eq("taxes.json")
    end

    it "CollectionProxy#client should return a Invoicexpress::Tax object" do
      expect(subject.all.client).to eq($client)
    end

    it "CollectionProxy#collection_name should return 'taxes' string" do
      expect(subject.all.collection_name).to eq("taxes")
    end

    it "CollectionProxy#count", :vcr do
      collection = subject.all.to_a
      expect(collection.size).to eq(4)
    end

    it "CollectionProxy#count", :vcr do
      collection = subject.all.to_a
      expect(collection.first).to be_instance_of(Invoicexpress::Model::Tax)
    end
  end

  describe "#find" do
    it "fetch existing tax record", :vcr do
      tax_id = 82613
      tax = subject.find(tax_id)
      expect(tax).to be_instance_of(Invoicexpress::Model::Tax)
      expect(tax.id).to eq(tax_id)
    end

    it "tax record not found", :vcr do
      tax_id = 0
      expect{ subject.find(tax_id) }.to raise_error(Invoicexpress::NotFound)
    end
  end

  describe "#create" do
    it "create new tax record", :vcr do
      tax = {
        "name": "IVA37",
        "value": "37.0",
        "region": "PT",
        "default_tax": "0"
      }
      new_tax = subject.create(tax)
      expect(new_tax).to be_instance_of(Invoicexpress::Model::Tax)
    end

    it "create a duplicate tax record", :vcr do
      tax = {
        "name": "IVA23",
        "value": "23.0",
        "region": "PT",
        "default_tax": "1"
      }
      expect{ subject.create(tax) }.to raise_error(Invoicexpress::UnprocessableEntity)
    end
  end

  describe "#delete" do
    it "delete tax", :vcr do
      tax_id = 231844
      expect(subject.delete(tax_id)).to be_nil
    end

    it "delete nonexistent tax", :vcr do
      tax_id = 0
      expect{ subject.delete(tax_id) }.to raise_error(Invoicexpress::NotFound)
    end
  end

end
