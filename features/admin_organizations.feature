Feature: Admin organizations
  In order to admin organizations
  As an admin
  I want crud organizations
  
  Background:
    Given I logged in as admin
    And the following organizations exist
      | name       |
      | Department |
      | BigDeal    |
    And the following members exist
      | name | organization |
      | Andy | Department   |
      | Eric | Department   |
      | Jane | Department   |
    And I go to the admin oganizations page
  
  Scenario: List organizations
    Then I should see 'Department'
    And I should see 'BigDeal'

  Scenario: Create organization
    When I follow "New Orngaization"
    And I fill the form with name: "BigBang"
    And I press "Create Orngaization"
    Then I should be on admin oganizations page
    And I should see "BigBang"

  Scenario: Update organization
    When I follow "Edit" within "BigDeal"
    And I fill in "SmallDeal" for "Name"
    And I press "Update"
    Then I should be on admin organizations page
    And I should see "SmallDeal"
    And I should not see "BigDeal"

  Scenario: Delete organization with members
    When I press "Delete" within "Department"
    Then I should be on admin organizations page
    And I should see "failed"
    And organization should exist with name: "Department"

  Scenario: Delete blank organization
    Given no member exist with organization: "BigDeal"
    When I press "Delete" within "BigDeal"
    Then I should be on admin organizations page
    And I should see "successful"
    And organization should not exist with name: "BigDeal"
