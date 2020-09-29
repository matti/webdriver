module Webdriver
  # 10
  class StaleElementReferenceError < StandardError; end
  # 11
  class ElementNotInteractableError < StandardError; end
  # 13
  class UnknownErrorUnhandledInspectorError < StandardError; end
  # 28
  class ScriptTimeout < StandardError; end
end
