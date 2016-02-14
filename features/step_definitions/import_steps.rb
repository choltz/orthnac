require_relative 'common_steps'

Before do
  File.delete('imports/test_transactions1.csv') if File.exist?('imports/test_transactions1.csv')
  File.delete('imports/test_not_csv.txt')       if File.exist?('imports/test_not_csv.txt')
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

Then(/^"([^"]*)" should exist$/) do |file|
  assert File.exist?(file), 'The file should be copied into the imports folder'
end

Then(/^"([^"]*)" should not exist$/) do |file|
  assert !File.exist?(file), 'The file should be copied into the imports folder'
end

Then(/^redirect to "([^"]*)"$/) do |path|
  assert current_path == path
end

Then(/^the "([^"]*)" table has "([^"]*)" rows$/) do |table, count|
  assert_equal count.to_i, page.all("#{table} tbody tr").count
end

Then(/^shows a "([^"]*)" link in the "([^"]*)" table$/) do |type, table|
  if type == "download"
    elements = page.all("#{table} tbody tr td")
    assert_equal 'play_for_work', elements.last.text
  elsif type == "error"
    elements = page.all("#{table} tbody tr td")
    assert_equal 'error', elements.last.text
  end
end

Given(/^I attach "([^"]*)" to 'import_file'$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^page should redirect to the import index page$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I go to the "([^"]*)" page$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the "([^"]*)" has "([^"]*)" rows$/) do |arg1, arg2|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I click the download link$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^"([^"]*)" should be downloaded$/) do |file|
  result = page.response_headers['Content-Type'].should == "application/octet-stream"

  if result
    result = page.response_headers['Content-Disposition'].should =~ /#{file}/
  end
end
