module Webdriver
  class Cookie
    attr_reader :name

    def initialize(name, connection)
      @name = name
      @session_connection = connection
      @connection = Webdriver::PrefixConnection.new "cookie/#{@name}", connection
    end

    def delete!
      @connection.delete
      self
    end

    def domain
      __refresh["domain"]
    end

    def expiry
      __refresh["expiry"]
    end

    def http_only
      __refresh["httpOnly"]
    end

    def path
      __refresh["path"]
    end

    def same_site
      __refresh["sameSite"]
    end

    def secure
      __refresh["secure"]
    end

    def value
      __refresh["value"]
    end

    private

    def __refresh
      @connection.get
    end
  end
end
