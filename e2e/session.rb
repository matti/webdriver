session = $client.session!
raise unless session.id

session.delete!
