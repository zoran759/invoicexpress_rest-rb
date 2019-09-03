# InvoiceXpress Rest

[![Maintainability](https://api.codeclimate.com/v1/badges/be131dd589b736269ff3/maintainability)](https://codeclimate.com/github/lmmendes/invoicexpress_rest-rb/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/be131dd589b736269ff3/test_coverage)](https://codeclimate.com/github/lmmendes/invoicexpress_rest-rb/test_coverage)
[![Build Status](https://travis-ci.org/lmmendes/invoicexpress_rest-rb.svg?branch=master)](https://travis-ci.org/lmmendes/invoicexpress_rest-rb)

A InvoiceXpress (https://invoicexpress.com) API wrapper (for API version 2.0 REST)

## Install

```
gem install invoicexpress-rest
```

## Examples

### Configuration

```ruby
# You can set Invoicexpress configuration at class level like so
Invoicexpress.configure do |c|
  c.api_key   = ENV['INVOICE_EXPRESS_API_KEY']
  c.account_name = ENV['INVOICE_EXPRESS_ACCOUNT_NAME']
end

# Or configure each instance independently
@client = Invoicexpress.new(
  api_key: ENV['API_KEY']
  account_name: ENV['INVOICE_EXPRESS_ACCOUNT_NAME']
)
```

### Invoices

```ruby

# This method returns all invoices.
@client.invoices.all()

```

## Bug reports and other issues

* https://github.com/lmmendes/invoicexpress_rest-rb/issues

## Help and Docs

* https://github.com/lmmendes/invoicexpress_rest-rb/wiki

## Contributing

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Send me a pull request. Bonus points for topic branches.

## License

Colombo is free software distributed under the terms of the MIT license reproduced [here](http://opensource.org/licenses/mit-license.html).
