Feature: Dashaboard page

Scenario: Dashboard monthly spending to date
  Given I am on the "imports" page
  And it is currently "1/30/2016"
  And I attach "test/data/test_transactions1.csv" to "import_file"
  And I navigate to the "dashboard" page
  Then the spending to date value should be "$839.44"
