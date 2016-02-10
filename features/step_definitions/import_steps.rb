Given(/^I am on the "([^"]*)" page$/) do |route|
  visit "/#{route}"
end

Given(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  page.fill_in field, with: value
end

When(/^I press "([^"]*)"$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^page should redirect to to the import index page$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
