module Webdriver
  class Session
    attr_reader :id

    def initialize(json, connection)
      @id = json.dig "id"
      @connection = Webdriver::PrefixConnection.new "session/#{@id}", connection
    end

    def delete!
      @connection.delete
    end

    def windows
      value = @connection.get "window/handles"
      value.map { |id| Webdriver::Window.new id, @connection }
    end

    def url! url
      @connection.post "url", {}, {
        url: url
      }
    end

    def url
      @connection.get "url"
    end

    def back!
      @connection.post "back"
    end

    def forward!
      @connection.post "forward"
    end

    def refresh!
      @connection.post "refresh"
    end

    def title
      @connection.get "title"
    end

    def execute_sync! script, args=[]
      @connection.post "execute/sync", {}, {
        script: script,
        args: args
      }
    end

    def screenshot
      @connection.get "screenshot"
    end
  end
end
