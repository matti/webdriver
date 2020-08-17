module Webdriver
  class Window
    attr_reader :id
    def initialize(id, connection)
      @id = id
      @session_connection = connection
      @connection = Webdriver::PrefixConnection.new "window/#{@id}", connection
    end

    def size
      @connection.get "size"
    end

    def position
      @connection.get "position"
    end

    def position! opts
      @connection.post "position", {}, opts
    end

    def maximize!
      @connection.post "maximize"
      self
    end

    def minimize!
      @session_connection.post "window/minimize"
      self
    end

    def rect! width: nil, height: nil, x: nil, y:nil
      @session_connection.post "window/rect", {}, {
        width: width,
        height: height,
        x: x,
        y: y
      }
      self
    end

    def rect
      @session_connection.get "window/rect"
    end

    def fullscreen!
      @connection.post "fullscreen"
      self
    end

    def close!
      @connection.delete
      self
    end
  end
end
