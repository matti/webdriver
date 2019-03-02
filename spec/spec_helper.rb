require "bundler/setup"
require "webdriver"

require "pry-byebug"
#require "pry-rescue/rspec"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before :each do
    @__chromedriver_pid = Process.spawn "chromedriver --silent >/dev/null"

    begin
      Net::HTTP.get URI("http://localhost:9515/status")
    rescue Errno::ECONNREFUSED
      print "."
      sleep 0.1
      retry
    end

    @client = Webdriver::Client.new("http://localhost:9515", {
      chromeOptions: {
        args: %w(headless)
      }
    })
  end

  config.after :each do
    @client.sessions.map(&:delete)
    Process.kill "TERM", @__chromedriver_pid
  end
end

if defined?(PryByebug)
  Pry::Commands.command /^$/, "quit" do
    _pry_.run_command "quit"
  end

  Pry.commands.alias_command '\n', 'quit'
  Pry.commands.alias_command 'q', 'quit'
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end
