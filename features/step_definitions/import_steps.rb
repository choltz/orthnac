Before do
  File.delete('tmp/transactions.csv') if File.exists?('tmp/transactions.csv')
end

Given(/^I am on the "([^"]*)" page$/) do |route|
  visit "/#{route}"
end

Given(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  page.fill_in field, with: value
end

Given(/^I attach "([^"]*)" to "([^"]*)"$/) do |file, field|
  attach_file(field, file)
end

When(/^I press "([^"]*)"$/) do |button|
  click_button button
end

Then(/^page should redirect to to the import index page$/) do
  assert_equal import_path, page.current_path
end

Then(/^"([^"]*)" should be copied to the "([^"]*)"$/) do |file, folder|
  assert File.exists?('tmp/transactions.csv')
end

Then(/^import index page shows the uploaded file$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
