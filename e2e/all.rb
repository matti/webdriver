require_relative "../lib/webdriver"
$client = Webdriver::Client.new "http://localhost:9515"
$client.sessions.map(&:delete!)

require_relative "status"
require_relative "sessions"
require_relative "session"
require_relative "windows"
require_relative "window"
require_relative "element"
puts "OK"
