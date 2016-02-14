Feature: Show transactions

Scenario: show the transaction list
  Given I am on the "imports" page
  And I attach "test/data/test_transactions1.csv" to "import_file"
  And I go to the "transactions" page
  Then the ".transaction-table" has "10" rows

Scenario: imports a file with overlapping transactions
  Given I am on the "imports" page
  And I attach "test/data/test_transactions1.csv" to "import_file"
  And I attach "test/data/test_transactions_with_overlap.csv" to "import_file"
  And I go to the "transactions" page
  Then the ".transaction-table" has "12" rows
