require 'spec_helper'

RSpec.describe Invoicexpress::Service::Sequence do
  before { $client = Invoicexpress::Client.new(account_name: ACCOUNT_NAME, api_key: API_KEY) }
  subject{ Invoicexpress::Service::Sequence.new($client) }

  describe "#all" do
    it "should return a CollectionProxy" do
      expect(subject.all).to be_instance_of(Invoicexpress::CollectionProxy)
    end

    it "CollectionProxy#collection_url should return 'sequences.json' string" do
      expect(subject.all.collection_url).to eq("sequences.json")
    end

    it "CollectionProxy#client should return a Invoicexpress::Client object" do
      expect(subject.all.client).to eq($client)
    end

    it "CollectionProxy#collection_name should return 'sequences' string" do
      expect(subject.all.collection_name).to eq("sequences")
    end
  end

  describe '#create' do
    it 'store a new sequence', :vcr do
      sequence_data = {
        serie: 2017,
        default_sequence: 1
      }
      clt = subject.create(sequence_data)
      expect(clt).to be_instance_of(Invoicexpress::Model::Sequence)
      expect(clt.id).to be > 0
      expect(clt.serie).to eq(2017)
    end
  end

end
