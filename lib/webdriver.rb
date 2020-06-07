$stdout.sync = true

require "net/http"
require "json"

module Webdriver
  def self.debug(args)
    return unless ENV["WEBDRIVER_DEBUG"]
    p args
  end
end

require_relative "webdriver/version"
require_relative "webdriver/errors"

require_relative "webdriver/connection"
require_relative "webdriver/prefix_connection"

require_relative "webdriver/window"
require_relative "webdriver/session"
require_relative "webdriver/element"
require_relative "webdriver/client"
require_relative "webdriver/cookie"
