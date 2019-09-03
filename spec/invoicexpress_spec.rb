require 'spec_helper'

RSpec.describe Invoicexpress do
  it "has a version number" do
    expect(Invoicexpress::VERSION).not_to be nil
  end

  it "expect api key and account name" do
    expect{ Invoicexpress.new }.to raise_error(Invoicexpress::ConfigurationError)
  end
end
