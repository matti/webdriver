require_relative "../lib/webdriver"

s = (Webdriver::Client.new "http://localhost:9515/").session!

s.url! "https://example.com"

3.times do |i|
  all_a_els = s.elements "css selector", "a"
  all_a_els&.first.click!
  sleep 1
end

s.delete!
