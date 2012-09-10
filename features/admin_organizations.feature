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
      | user_name | group_name |
      | Andy      | Department |
      | Eric      | Department |
      | Jane      | Department |
    And I go to the admin organizations page
  
  Scenario: List organizations
    Then I should see 'Department'
    And I should see 'BigDeal'

  Scenario: Create organization
    When I follow "New Organization"
    And I fill in "BigBang" for "Name"
    And I press "Create Organization"
    Then I should be on the admin organizations page
    And I should see "BigBang"

  Scenario: Update organization
    When I click "Edit" of organization "BigDeal"
    And I fill in "SmallDeal" for "Name"
    And I press "Update Organization"
    Then I should be on the admin organizations page
    And I should see "SmallDeal"
    And I should not see "BigDeal"

  Scenario: Delete organization with members
    When I click "Delete" of organization "Department"
    Then I should be on the admin organizations page
    And I should see "could not"
    And organization should exist with name: "Department"

  Scenario: Delete blank organization
    When I click "Delete" of organization "BigDeal"
    Then I should be on the admin organizations page
    And I should see "successfully"
    And organization should not exist with name: "BigDeal"
