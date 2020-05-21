module Webdriver
  class PrefixConnection
    def initialize(prefix, connection)
      @prefix = prefix
      @connection = connection
    end

    def get path=nil, headers={}
      call :get, path, headers
    end

    def post path=nil, headers={}, body=nil
      call :post, path, headers, body
    end

    def delete path=nil, headers={}, body=nil
      call :delete, path, headers, body
    end

    def call method, path=nil, headers={}, body=nil
      prefixed_path = if path
        "#{@prefix}/#{path}"
      else
        "#{@prefix}"
      end

      @connection.call method, prefixed_path, headers, body
    end
  end
end
