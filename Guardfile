guard :rspec, {
  cmd: "bundle exec rspec",
  all_on_start: true,
  all_after_pass: true,
  failed_mode: :focus
  } do
  require "guard/rspec/dsl"
  dsl = Guard::RSpec::Dsl.new(self)

  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)

  watch(/.+\.rb$/) { |m| puts m }
  watch(/.+\.rb$/) { "spec" }
end

require_relative "lib/webdriver"

Process.spawn "chromedriver"

begin
  Net::HTTP.get URI("http://localhost:9515/status")
rescue Errno::ECONNREFUSED
  print "."
  sleep 0.1
  retry
end


$client = Webdriver::Client.new "http://localhost:9515"

at_exit do
  puts "killing chromedriver"
  Process.kill "TERM", $__chromedriver_pid
end
