Feature: Basic Navigation

Scenario: navigate to the home page
  Given I navigate to the "/imports" page
  And I click on the "dashboard-desktop" Link
  Then page should redirect to "/dashboard"

Scenario: navigate to the imports page
  Given I navigate to the "/" page
  And I click on the "imports-desktop" Link
  Then page should redirect to "/imports"

Scenario: navigate to the transactions page
  Given I navigate to the "/" page
  And I click on the "transactions-desktop" Link
  Then page should redirect to "/transactions"

Scenario: navigate to the dashboard
  Given I navigate to the "/" page
  And I click on the "dashboard-desktop" Link
  Then page should redirect to "/dashboard"

Scenario: Navigate to settings page
  Given I navigate to the "/" page
  And I click on the "settings-desktop" Link
  Then page should redirect to "/settings"
