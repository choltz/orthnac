Feature: Dashaboard page

Scenario: Monthly spending to date
  Given I am on the "imports" page
  And it is currently "1/30/2016"
  And I attach "test/data/test_transactions1.csv" to "import_file"
  And I navigate to the "dashboard" page
  Then the spending to date value should be "$839.44"

Scenario: Spending totals by month
  Given I am on the "imports" page
  And it is currently "1/30/2016"
  And I attach "test/data/test_transactions1.csv" to "import_file"
  And I navigate to the "dashboard" page
  Then the spending totals by month for "january" should be "10.00"
  And the spending totals by month for "february" should be "10.00"
  And the spending totals by month for "march" should be "10.00"
  And the spending totals by month for "april" should be "10.00"
  And the spending totals by month for "may" should be "10.00"
  And the spending totals by month for "june" should be "10.00"
  And the spending totals by month for "july" should be "10.00"
  And the spending totals by month for "august" should be "10.00"
  And the spending totals by month for "september" should be "10.00"
  And the spending totals by month for "october" should be "10.00"
  And the spending totals by month for "november" should be "10.00"
  And the spending totals by month for "december" should be "10.00"
