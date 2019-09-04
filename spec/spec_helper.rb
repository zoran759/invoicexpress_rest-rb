require "bundler/setup"

# simplecov needs to be added before any projects files are required
require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

ACCOUNT_NAME = ENV['INVOICE_EXPRESS_ACCOUNT_NAME'].freeze
API_KEY = ENV['INVOICE_EXPRESS_AKI_KEY'].freeze

Bundler.require(:default, :development)
require "invoicexpress"

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data('API_KEY') { API_KEY }
  c.filter_sensitive_data('ACCOUNT_NAME') { ACCOUNT_NAME }
  c.configure_rspec_metadata!
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
