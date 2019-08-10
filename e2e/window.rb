session = $client.session!
w = session.windows.first
w.maximize!.minimize!

raise "x not 0" unless w.rect["x"] == 0
session.delete!
