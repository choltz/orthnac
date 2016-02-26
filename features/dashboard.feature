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
  And I attach "test/data/test_month_sums.csv" to "import_file"
  And I navigate to the "dashboard" page
  Then the spending totals by month for "month-2015-01" should be "$45.00"
  And the spending totals by month for "month-2015-02" should be "$35.00"
  And the spending totals by month for "month-2015-03" should be "$19.43"
  And the spending totals by month for "month-2015-04" should be "$29.00"
  And the spending totals by month for "month-2015-05" should be "$49.00"
  And the spending totals by month for "month-2015-06" should be "$22.43"
  And the spending totals by month for "month-2015-07" should be "$11.11"
  And the spending totals by month for "month-2015-08" should be "$39.00"
  And the spending totals by month for "month-2015-09" should be "$69.12"
  And the spending totals by month for "month-2015-10" should be "$25.28"
  And the spending totals by month for "month-2015-11" should be "$245.11"
  And the spending totals by month for "month-2015-12" should be "$54.32"
  And the spending totals by month for "month-2016-01" should be "$120.00"
