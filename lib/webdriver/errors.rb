module Webdriver
  # 7
  class NoSuchElementError < StandardError; end
  # 7
  class NoSuchFrameError < StandardError; end
  # 10
  class StaleElementReferenceError < StandardError; end
  # 11
  class ElementNotInteractableError < StandardError; end
  # 13
  class UnknownErrorUnhandledInspectorError < StandardError; end
  # 17
  class JavascriptError < StandardError; end
  # 23
  class NoSuchWindow < StandardError; end
  # 26
  class UnexpectedAlertOpen < StandardError; end
  # 27
  class NoSuchAlert < StandardError; end
  # 28
  class ScriptTimeout < StandardError; end
end
