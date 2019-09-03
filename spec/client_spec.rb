require 'spec_helper'

RSpec.describe Invoicexpress::Client do

  let(:client){ Invoicexpress::Client.new(account_name: ACCOUNT_NAME, api_key: API_KEY) }

  it "empty api key or account name throw  ConfigurationError exception" do
    expect{ Invoicexpress::Client.new }.to raise_error Invoicexpress::ConfigurationError
  end

  it "invalid credentials throw Unauthorized exception", :vcr do
    invalid_client = Invoicexpress::Client.new(
      api_key: 'invalid-api-key',
      account_name: 'invalid-account-name'
    )
    expect{ invalid_client.get('invoices.json') }.to raise_error Invoicexpress::Unauthorized
  end

  it "#invoices method returns Service::Invoice object instance" do
    expect(client.invoices).to be_instance_of Invoicexpress::Service::Invoice
  end

  it "#clients method returns Service::Client object instance" do
    expect(client.clients).to be_instance_of Invoicexpress::Service::Client
  end

end
