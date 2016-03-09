Feature: Show transactions

Scenario: show the transaction list
  Given I am on the "imports" page
  And I attach "test/data/test_transactions1.csv" to "import_file"
  And I navigate to the "transactions" page
  Then the ".transaction-table" table has "15" rows

Scenario: imports a file with overlapping transactions
  Given I am on the "imports" page
  And I attach "test/data/test_transactions1.csv" to "import_file"
  And I attach "test/data/test_transactions2.csv" to "import_file"
  And I navigate to the "transactions" page
  Then the ".transaction-table" table has "16" rows

Scenario: search for transactions by category
  Given I am on the "imports" page
  And I attach "test/data/test_transactions1.csv" to "import_file"
  And I navigate to the "transactions" page
  And I fill in "search" with "Medical"
  And I press the "Search" button
  Then the ".transaction-table" table has "5" rows

Scenario: search for transactions by merchant
  Given I am on the "imports" page
  And I attach "test/data/test_transactions1.csv" to "import_file"
  And I navigate to the "transactions" page
  And I fill in "search" with "Amazon"
  And I press the "Search" button
  Then the ".transaction-table" table has "3" rows

Scenario: search for transactions by amount
  Given I am on the "imports" page
  And I attach "test/data/test_transactions1.csv" to "import_file"
  And I navigate to the "transactions" page
  And I fill in "search" with "29.00"
  And I press the "Search" button
  Then the ".transaction-table" table has "1" rows

Scenario: filter transactions by category

Scenario: filter transactions by merchant

Scenario: filter transactions by date range
