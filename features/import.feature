Feature: Import transactions
  In order to view transaction
  A visitor
  Should should import a file

Scenario: imports a file and shows a history of imports
  Given I am on the "imports" page
  And I attach "test/data/test_transactions1.csv" to "import_file"
  Then page should redirect to to the import index page
  And "file" should be copied to "imports/test_transactions1.csv"
  And redirect to "/imports"
  And the ".import-table" table has "1" rows

Scenario: imports a non-csv file

Scenario: imports nonthing
  # show message

Scenario: import format errors

Scenario: Views a list of imported files
  # what fields are visible
  # should have a link to the saved import file
