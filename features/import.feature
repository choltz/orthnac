Feature: Import transactions
  In order to view transaction
  A visitor
  Should should import a file

Scenario: imports a file and shows a history of imports
  Given I am on the "imports" page
  And I attach "test/data/test_transactions1.csv" to "import_file"
  Then page should redirect to to the import index page
  And "imports/test_transactions1.csv" should exist
  And redirect to "/imports"
  And the ".import-table" table has "1" rows
  And shows a "download" link in the ".import-table" table

Scenario: imports a non-csv file
  Given I am on the "imports" page
  And I attach "test/data/test_not_csv.txt" to "import_file"
  Then page should redirect to to the import index page
  And "imports/test_not_csv.txt" should not exist
  And the ".import-table" table has "1" rows
  And shows a "!" link in the ".import-table" table

Scenario: download csv file
  Given I am on the "imports" page
  And I attach "test/data/test_transactions1.csv" to 'import_file'
  And I click the download link
  Then "test_transactions1.csv" should be downloaded

Scenario: import format errors
  Given I am on the "imports" page
  And I attach "test/data/test_format_problem.csv" to 'import_file'
  Then page should redirect to the import index page
  And "file" should not be copied to the "imports" folder
  And shows the message "CSV format problem"
  And the ".import-table" table has "0" rows
