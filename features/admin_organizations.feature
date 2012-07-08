Feature: Admin organizations
  In order to admin organizations
  As an admin
  I want crud organizations
  
  Background:
    Given I logged in as admin
    And I go to the admin oganizations page
  
  Scenario: list organizations
    Given the following organizations exist
      | name       |
      | Department |
      | BigDeal    |
    Then I should see 'Department'
    And I should see 'BigDeal'
  
  
    

  
  
  
  

  
