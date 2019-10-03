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

      faraday_init[:params] = get_query_params(faraday_init[:params].merge(params)) unless params.nil?

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

      # TODO: Fix issue with clients/client_id/invoices.json that is returning
      #       HTML instead of json content
      #
      begin
        description = JSON.parse(response.body) unless empty_payload?(response.body)
      rescue JSON::ParserError => e
        raise NotFound, e
      end


      if description.nil?
        message = response.reason_phrase
      elsif description.is_a?(Hash) && description["errors"] && description["errors"].is_a?(Array) && description["errors"].size != 0
        message = "#{response.reason_phrase}: #{description["errors"][0].values.first}"
      elsif description.is_a?(Array) && description.size != 0
        message = "#{response.reason_phrase}: #{description.collect{ |a, b| "#{a} #{b}" }.join(', ')}"
      else
        message = "#{response.reason_phrase}: #{description}"
      end

      case response.status
      when 401
        raise Unauthorized, message
      when 404
        raise NotFound, message
      when 406
        raise NotAcceptable, message
      when 422
        raise UnprocessableEntity, message
      end
    end

    def empty_payload?(body)
      body.to_s.strip.empty?
    end

    def get_query_params(params)
      params.reject{ |k,v| v.nil? }
    end

  end
end
