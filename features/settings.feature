Feature: Settings

@javascript
Scenario: Update statement date
  Given I navigate to the "settings" page
  And I fill in "Billing statement start day" with "10"
  And I click on the "Save" Link
  Then the message "Settings updated" should be displayed

@javascript
Scenario: Update statement blank date
  Given I navigate to the "settings" page
  And I fill in "Billing statement start day" with ""
  And I click on the "Save" Link
  Then the warning "Statement start day can't be blank" should be displayed

@javascript
Scenario: Cancel button
  Given I navigate to the "settings" page
  And I fill in "Billing statement start day" with ""
  And I click on the "Cancel" Link
  Then the message "The changes have been reverted" should be displayed
