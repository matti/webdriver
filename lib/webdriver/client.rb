module Webdriver
  class Client
    def initialize(endpoint, desired_capabilities={})
      uri = URI(endpoint)
      @connection = Webdriver::Connection.new endpoint
      @desired_capabilities = desired_capabilities
    end

    def status
      @connection.get "status"
    end

    def sessions
      value = @connection.get "sessions"
      value.map { |json| Webdriver::Session.new json, @connection }
    end

    def session!
      json = @connection.post "session", {}, {
        desiredCapabilities: @desired_capabilities
      }

      Webdriver::Session.new json, @connection
    end

  end
end
