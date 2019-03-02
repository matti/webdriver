$stdout.sync = true

require "net/http"
require "json"

module Webdriver
end

require_relative "webdriver/version"
require_relative "webdriver/connection"
require_relative "webdriver/prefix_connection"

require_relative "webdriver/window"
require_relative "webdriver/session"
require_relative "webdriver/client"
