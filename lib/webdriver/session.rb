module Webdriver
  class Session
    attr_reader :id

    def initialize(json, connection)
      @id = json.dig "id"
      @connection = Webdriver::PrefixConnection.new "session/#{@id}", connection
    end

    def delete
      @connection.delete
    end

    def windows
      value = @connection.get "window/handles"
      value.map { |id| Webdriver::Window.new id, @connection }
    end
  end
end
