Feature: Import transactions
  In order to view transaction
  A visitor
  Should should import a file

Scenario: imports a file
  Given I am on the "imports" page
  And I fill in "Import File" with "tmp/transactions.csv"
  When I press "Import"
  Then page should redirect to to the import index page
