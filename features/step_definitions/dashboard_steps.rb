Before do
  File.delete('imports/test_transactions1.csv') if File.exist?('imports/test_transactions1.csv')
end

Then(/^the spending to date value should be "([^"]*)"$/) do |amount|
  elements = page.all(".monthly-sum-to-date")
  assert_equal amount, elements.first.text
end
