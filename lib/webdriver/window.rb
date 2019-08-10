module Webdriver
  class Window
    attr_reader :id
    def initialize(id, connection)
      @id = id
      @connection = Webdriver::PrefixConnection.new "window", connection
    end

    def maximize!
      @connection.post "maximize"
      self
    end

    def minimize!
      @connection.post "minimize"
      self
    end

    def rect! width: nil, height: nil, x: nil, y:nil
      @connection.post("rect", {}, {
        width: width,
        height: height,
        x: x,
        y: y
      })
      rect
    end

    def rect
      @connection.get "rect"
    end

    def fullscreen!
      @connection.post "fullscreen"
    end

    def close!
      @connection.delete
    end
  end
end
