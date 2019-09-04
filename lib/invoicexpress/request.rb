module Invoicexpress
  module Request

    def request(method=:get, uri='/', params = nil, body = nil, &block)
      # https://ACCOUNT_NAME.app.invoicexpress.com/invoices.json?api_key=API_KEY
      url = "https://" + self.account_name.to_s + '.' + self.endpoint.to_s

      faraday_init = {
        url: url,
        headers: {
          content_type: 'application/json',
          user_agent: user_agent
        },
        params: {
          api_key: api_key
        }
      }

      faraday_init[:params] = faraday_init[:params].merge(params) unless params.nil?

      faraday = Faraday.new(faraday_init)

      response = nil
      begin
        response = faraday.send(method, uri) do |request|
          request.body = body.to_json unless empty_payload?(body)
        end
      rescue => e
        $stderr.puts e.inspect
      end

      if response.success?
        body = response.body
        if block_given?
          block.call(body)
        else
          JSON.parse(body) unless empty_payload?(body)
        end
      else
        raise_error!(response)
      end
    end

    private
    def raise_error!(response)
      case response.status
      when 401
        raise Unauthorized, response.reason_phrase
      when 404
        raise NotFound, response.reason_phrase
      when 406
        raise NotAcceptable, response.reason_phrase
      when 422
        raise UnprocessableEntity, response.reason_phrase
      end
    end

    def empty_payload?(body)
      body.to_s.strip.empty?
    end

  end
end
