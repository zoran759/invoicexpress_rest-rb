module Invoicexpress
  class Exception < StandardError; end
  class Unauthorized < Exception; end
  class UnprocessableEntity < Exception; end
  class NotFound < Exception; end
  class ConfigurationError < Exception; end
  class NotAcceptable < Exception; end
end
