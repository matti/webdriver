session = $client.session!
raise "windows not 1" unless session.windows.size == 1

session.delete!
