module Webdriver
  class Session
    attr_reader :id

    def initialize(json, connection)
      @id = json.dig "id"
      @connection = Webdriver::PrefixConnection.new "session/#{@id}", connection
    end

    def delete!
      @connection.delete
      self
    end

    def windows
      value = @connection.get "window/handles"
      value.map { |id| Webdriver::Window.new id, @connection }
    end

    # not implemented in chromedriver
    # def source
    #   @connection.post "source"
    # end

    def dismiss_alert!
      @connection.post "alert/dismiss"
      self
    end

    def accept_alert!
      @connection.post "alert/accept"
      self
    end

    def alert_text
      @connection.get "alert/text"
    end

    # TODO: Does not work with prompt
    # def alert_text! text
    #   @connection.post "alert/text", {}, {
    #     text: text
    #   }
    # end

    # iframe id
    def frame! name
      @connection.post "frame", {}, {
        id: name
      }
      self
    end

    def parent_frame!
      @connection.post "frame/parent", {}, {}
      self
    end

    def url! url
      @connection.post "url", {}, {
        url: url
      }
      self
    end

    def url
      @connection.get "url"
    end

    def back!
      @connection.post "back"
      self
    end

    def forward!
      @connection.post "forward"
      self
    end

    def refresh!
      @connection.post "refresh"
      self
    end

    def title
      @connection.get "title"
    end

    def cookies
      resp = @connection.get "cookie"

      resp.map { |el| Webdriver::Cookie.new el["name"], @connection }
    end

    def cookies_delete!
      @connection.delete "cookie"
      self
    end

    def cookie name
      resp = @connection.get File.join("cookie",name)
      Webdriver::Element.new resp["name"], @connection
    end

    #TODO: ??
    # def cookie_add(name, value)
    #   @connection.post "cookie", {}, {
    #     name: name,
    #     args: {
    #       cookie: value,
    #     },
    #   }
    # end

    # TODO: hangs
    # def execute_async! script, args=[]
    #   @connection.post "execute/async", {}, {
    #     script: script,
    #     args: args
    #   }
    # end

    def execute_sync! script, args=[]
      resp = @connection.post "execute/sync", {}, {
        script: script,
        args: args
      }

      value = if resp.is_a?(Hash) && resp["ELEMENT"]
        begin
          el = Webdriver::Element.new resp["ELEMENT"], @connection
          el.tag
          el
        rescue
          resp
        end
      elsif resp.is_a?(Array)
        begin
          resp.map do |r|
            el = Webdriver::Element.new r["ELEMENT"], @connection
            el.tag
            el
          end
        rescue
          resp
        end
      else
        resp
      end
    end

    # not implemented in chromedriver
    # def print!
    #   @connection.post "print"
    # end

    def screenshot
      @connection.get "screenshot"
    end

    # when moving with tab, or clicked
    def active_element
      el = @connection.get "element/active"
      Webdriver::Element.new el["ELEMENT"], @connection
    end

    def element using, value
      el = @connection.post "element", {}, {
        using: using,
        value: value
      }
      Webdriver::Element.new el["ELEMENT"], @connection
    end

    def elements using, value
      resp = @connection.post "elements", {}, {
        using: using,
        value: value
      }
      resp.map { |el| Webdriver::Element.new el["ELEMENT"], @connection }
    end
  end
end
