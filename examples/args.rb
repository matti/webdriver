require_relative "../lib/webdriver"

capabilities = {
  chromeOptions: {
    args: [
      '--window-size=800,600',
      '--window-position=0,0',
    ]
  }
}

wd = Webdriver::Client.new "http://localhost:9515/wd/hub", capabilities
s = wd.session!
w = s.windows.first

s.delete!
