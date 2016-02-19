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

Then(/^"([^"]*)" should exist$/) do |file|
  assert File.exist?(file), 'The file should be copied into the imports folder'
end

Then(/^"([^"]*)" should not exist$/) do |file|
  assert !File.exist?(file), 'The file should be copied into the imports folder'
end

Then(/^redirect to "([^"]*)"$/) do |path|
  assert current_path == path
end

Then(/^shows a "([^"]*)" link in the "([^"]*)" table$/) do |type, table|
  if type == 'download'
    elements = page.all("#{table} tbody tr td")
    assert_equal 'play_for_work', elements.last.text
  elsif type == 'error'
    elements = page.all("#{table} tbody tr td")
    assert_equal 'error', elements.last.text
  end
end

Given(/^I attach "([^"]*)" to 'import_file'$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I go to the "([^"]*)" page$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I click the "([^"]*)" link in the "([^"]*)" table$/) do |link, table|
  page.all("#{table} tbody tr a").last.click
end

Then(/^"([^"]*)" should be downloaded$/) do |file|
  assert_equal 'application/octet-stream', page.response_headers['Content-Type']
  assert_equal "attachment; filename=\"#{file}\"", page.response_headers['Content-Disposition']
end
