# webdriver

A Ruby https://www.w3.org/TR/webdriver/ driver

## Notes for implementators

 - `element.value!` is slow when compared to JavaScript `el.value = ...`
 - element visibility helper `element.displayed?`
hitrate.
 - Remember to use JavaScript multiline strings \` \` in `session.async_exec`
 - looks like delaying 0.5s between element find and click improves
