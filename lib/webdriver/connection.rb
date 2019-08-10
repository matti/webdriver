module Webdriver
  class Connection
    def initialize(endpoint)
      uri = URI(endpoint)
      @http = Net::HTTP.new uri.hostname, uri.port
    end

    def get(path, headers={})
      call :get, path, headers
    end
    def post(path, headers={}, body=nil)
      call :post, path, headers, body
    end
    def post(path, headers={}, body=nil)
      call :post, path, headers, body
    end

    def call(method, path, headers={}, body={})
      path = "/#{path}"
      body_json = body.to_json if body
      Webdriver.debug [method, path, headers, body_json]

      response = case method
      when :get
        @http.get path
      when :post
        @http.post path, body_json
      when :delete
        @http.delete path, body_json
      else
        raise "err"
      end

      response_body = JSON.parse response.body

      status = response_body.dig "status"
      session_id = response_body.dig "sessionId"
      value = response_body.dig "value"

      case status
      when 0
        # POST /session has different response structure than other calls
        if method == :post && path == "/session"
          value.merge("id" => session_id)
        else # everything else works like this
          value
        end
      else
        if method == :get && path == "/status"
          value
        else
          pp [status, response_body]
          raise "err"
        end
      end
    end
  end
end
