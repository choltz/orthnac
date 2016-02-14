require_relative 'common_steps'

Before do
  File.delete('imports/test_transactions1.csv') if File.exists?('imports/test_transactions1.csv')
end

Given(/^I am on the "([^"]*)" page$/) do |route|
  visit "/#{route}"
end

Given(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  page.fill_in field, with: value
end

Given(/^I attach "([^"]*)" to "([^"]*)"$/) do |file, field|
  attach_file(field, file)
  click_button 'Import'
end

Then(/^page should redirect to to the import index page$/) do
  assert_equal import_path, page.current_path
end

Then(/^"([^"]*)" should be copied to "([^"]*)"$/) do |file, folder|
  assert File.exists?('imports/test_transactions1.csv')
end

Then(/^redirect to "([^"]*)"$/) do |path|
  assert current_path == path
end

Then(/^the "([^"]*)" table has "([^"]*)" rows$/) do |table, count|
  assert_equal count.to_i, page.all("#{table} tbody tr").count
end
