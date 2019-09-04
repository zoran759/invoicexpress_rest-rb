
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "invoicexpress/version"

Gem::Specification.new do |spec|
  spec.name          = "invoicexpress_rest"
  spec.version       = Invoicexpress::VERSION
  spec.authors       = ["Luis Mendes"]
  spec.email         = ["lmmendes@gmail.com"]

  spec.summary       = %q{InvoiceXpress API client}
  spec.description   = %q{A simple ruby client for InvoiceXpress REST API}
  spec.homepage      = "https://github.com/lmmendes/invoicexpress_rest-rb"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.3"
  spec.add_development_dependency "minitest", "~> 5.4"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'vcr', '~> 5.0'
  spec.add_development_dependency 'webmock', '~> 3.7', '>= 3.7.1'
  spec.add_development_dependency 'simplecov', '~> 0.12.0'
  spec.add_development_dependency 'pry-byebug', '~> 3.7'
end
