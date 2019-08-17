session = $client.session!
raise unless session.id

value = session.execute_sync! "return 1+2"
raise unless value == 3

value = session.execute_sync! "return arguments", [1,2,3]
raise unless value == [1,2,3]

session.delete!
