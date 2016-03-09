Then(/^page should redirect to "([^"]*)"$/) do |path|
  assert_equal path, page.current_path
end

Then(/^the "([^"]*)" block should read "([^"]*)"$/) do |selector, text|
  elements = page.all(selector)
  assert_equal text, elements.first.text
end

Given(/^I navigate to the "([^"]*)" page$/) do |route|
  visit "/#{route}"
end

Given(/^I click on the "([^"]*)" Link$/) do |link|
  click_link link
end

Then(/^the "([^"]*)" table has "([^"]*)" rows$/) do |table, count|
  assert_equal count.to_i, page.all("#{table} tbody tr").count
end

Given(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  page.fill_in field, with: value
end

Then(/^the message "([^"]*)" should be displayed$/) do |text|
  element = page.find_by_id('flash_message')
  assert_equal text, element.text
end

Then(/^the warning "([^"]*)" should be displayed$/) do |text|
  element = page.find_by_id('flash_warning')
  assert_equal text, element.text
end

Given(/^I press the "([^"]*)" button$/) do |button|
  click_button button
end

# Public: return the current relative path
def current_path
  URI.parse(current_url).path
end
