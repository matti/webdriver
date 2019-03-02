module Webdriver
  class Window
    attr_reader :id
    def initialize(id, connection)
      @id = id
      @connection = Webdriver::PrefixConnection.new "window", connection
    end

    def maximize
      @connection.post "maximize"
      self
    end

    def minimize
      @connection.post "minimize"
      self
    end

    def rect
      @connection.get "rect"
    end
  end
end
