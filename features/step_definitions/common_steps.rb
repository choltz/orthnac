Then(/^page should redirect to "([^"]*)"$/) do |path|
  assert_equal path, page.current_path
end

Then(/^the "([^"]*)" block should read "([^"]*)"$/) do |selector, text|
  elements = page.all(selector)
  assert_equal text, elements.first.text
end

# Public: return the current relative path
def current_path
  URI.parse(current_url).path
end
