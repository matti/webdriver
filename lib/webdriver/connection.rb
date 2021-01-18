module Webdriver
  class Connection
    def initialize endpoint, open_timeout: 3, read_timeout: 5, write_timeout: 5
      uri = URI(endpoint)
      @http = Net::HTTP.new uri.hostname, uri.port
      @http.open_timeout = open_timeout
      @http.read_timeout = read_timeout
      @http.write_timeout = write_timeout

      @mutex = Mutex.new
    end

    def get path, headers={}
      call :get, path, headers
    end

    def post path, headers={}, body=nil
      call :post, path, headers, body
    end

    def post path, headers={}, body=nil
      call :post, path, headers, body
    end

    def call method, path, headers={}, body={}
      path = "/#{path}"
      body_json = body.to_json if body
      Webdriver.debug [method, path, headers, body_json]

      response = @mutex.synchronize do
        case method
        when :get
          @http.get path
        when :post
          @http.post path, body_json
        when :delete
          @http.delete path, body_json
        else
          raise "err"
        end
      end

      response_body = JSON.parse response.body

      status = response_body.dig "status"
      session_id = response_body.dig "sessionId"
      value = response_body.dig "value"


      case status
      when nil
        # application_status_cache
        value
      when 0
        # POST /session has different response structure than other calls
        if method == :post && path == "/session"
          value.merge("id" => session_id)
        else # everything else works like this
          value
        end
      when 7
        raise Webdriver::NoSuchElementError.new value.dig("message")
      when 8
        raise Webdriver::NoSuchFrameError.new body[:id]
      when 10
        raise Webdriver::StaleElementReferenceError.new path
      when 11
        raise Webdriver::ElementNotInteractableError.new path
      when 13
        raise Webdriver::UnknownErrorUnhandledInspectorError.new value.dig("message")
      when 17
        raise Webdriver::JavascriptError.new value.dig("message")
      when 23
        raise Webdriver::NoSuchWindow.new value.dig("message")
      when 26
        raise Webdriver::UnexpectedAlertOpen.new value.dig("message")
      when 27
        raise Webdriver::NoSuchAlert.new value.dig("message")
      when 28
        raise Webdriver::ScriptTimeout.new value.dig("message")
      when 1..nil
        error_message = value.dig("message")
        raise "#{status}: #{error_message}"
      else
        if method == :get && path == "/status"
          value
        else
          raise "unknown status: #{status}"
        end
      end
    end
  end
end
