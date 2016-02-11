Feature: Import transactions
  In order to view transaction
  A visitor
  Should should import a file

Scenario: imports a file
  Given I am on the "imports" page
  And I attach "test/data/transactions.csv" to "import_file"
  When I press "Import"
  Then page should redirect to to the import index page
  And "file" should be copied to the "uploads folder"
  And import index page shows the uploaded file


Scenario: imports a new file

Scenario: imports a file with overlapping transactions

Scenario: imports a non-csv file

Scenario: imports nonthing

Scenario: Views a list of imported files
  # what fields are visible
  # should have a link to the saved import file
