Then(/^page should redirect to "([^"]*)"$/) do |path|
  assert_equal path, page.current_path
end

# Public: return the current relative path
def current_path
  URI.parse(current_url).path
end
