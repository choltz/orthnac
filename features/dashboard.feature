Feature: Dashaboard page

Scenario: Spending totals by month
  Given I am on the "imports" page
  And it is currently "1/30/2016"
  And I attach "test/data/test_month_sums.csv" to "import_file"
  And I navigate to the "dashboard" page
  Then the spending totals by month for "month-2015-02-01" should be "$35.00"
  And the spending totals by month for "month-2015-03-01" should be "$19.43"
  And the spending totals by month for "month-2015-04-01" should be "$29.00"
  And the spending totals by month for "month-2015-05-01" should be "$49.00"
  And the spending totals by month for "month-2015-06-01" should be "$22.43"
  And the spending totals by month for "month-2015-07-01" should be "$11.11"
  And the spending totals by month for "month-2015-08-01" should be "$39.00"
  And the spending totals by month for "month-2015-09-01" should be "$69.12"
  And the spending totals by month for "month-2015-10-01" should be "$25.28"
  And the spending totals by month for "month-2015-11-01" should be "$245.11"
  And the spending totals by month for "month-2015-12-01" should be "$54.32"
  And the spending totals by month for "month-2016-01-01" should be "$120.00"
