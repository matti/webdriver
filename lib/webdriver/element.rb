module Webdriver
  class Element
    attr_reader :id

    def initialize(id, connection)
      @id = id

      @session_connection = connection
      @connection = Webdriver::PrefixConnection.new "element/#{@id}", connection
    end

    def screenshot
      @connection.get "screenshot"
    end

    # checkbox
    def selected?
      @connection.get "selected"
    end

    # form control enabled
    def enabled?
      @connection.get "enabled"
    end

    def clear!
      @connection.post "clear"
      click!
    end

    def value! value
      value_string = value.to_s
      if value_string == ""
        clear!
      else
        @connection.post "value", {}, {
          value: [value_string]
        }
      end
    end

    def text
      @connection.get "text"
    end

    def rect
      @connection.get "rect"
    end

    def tag
      @connection.get "name"
    end

    def css name
      @connection.get File.join("css", name)
    end

    def property name
      @connection.get File.join("property", name)
    end

    def attribute name
      @connection.get File.join("attribute", name)
    end

    def click!
      @connection.post "click"
    end

    def element using, value
      el = @connection.post "element", {}, {
        using: using,
        value: value
      }
      Webdriver::Element.new el["ELEMENT"], @session_connection
    end

    def elements using, value
      resp = @connection.post "elements", {}, {
        using: using,
        value: value
      }
      resp.map { |el| Webdriver::Element.new el["ELEMENT"], @session_connection }
    end
  end
end
