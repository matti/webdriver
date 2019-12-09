require_relative "../lib/webdriver"

s = (Webdriver::Client.new "http://localhost:9515/").session!

s.url! "https://example.com"
html_el = s.element "css selector", "html"

puts html_el.text
puts "-- 8< -----------------------"
puts html_el.property "innerHTML"

s.delete!
