session = $client.session!

e = session.element "css selector", "html"
raise "text" unless e.text == ""
raise "property" unless e.property("innerHTML") == "<head></head><body></body>"
raise "attribute" unless e.attribute("innerHTML") == "<head></head><body></body>"
raise "tag" unless e.tag == "html"

raise "child" unless e.element("css selector", "body").tag == "body"
