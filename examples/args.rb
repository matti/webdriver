require_relative "../lib/webdriver"

capabilities = {
  chromeOptions: {
    args: [
      '--window-size=800,600',
      '--window-position=100,100',
    ]
  }
}

wd = Webdriver::Client.new "http://localhost:9515/wd/hub", capabilities
session = wd.session
p session.windows.first.rect
session.delete
