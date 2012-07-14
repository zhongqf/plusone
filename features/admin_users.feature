Feature: Admin users
  In order to admin users
  As an admin
  I want crud users
  
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
      | Jane | BigDeal      |
    And I go to the admin users page

  Scenario: List users
    Then I should see 'Andy'
    And I should see 'Eric'
    And I should see 'Jane'
    And I should see 'Department' within "Andy"
    And I should see 'Department' within "Eric"
    And I should see 'BigDeal' within "Jane"

  Scenario: New user
    When I follow "New user"
    And I fill in the following:
      | Name         | Daniel     |
      | Organization | Department |
    And press "Create user"
    Then I should be on admin users page
    And I should see "Daniel"
    And I should see "Department" within "Daniel"
    And should can login with name: "Daniel", password: "xxx"

  Scenario: Update user name
    When I follow "Edit" within "Eric"
    And I fill in "Tom" for "Name"
    And I press "Update User"
    Then I should be on admin users page
    And I should see "Tom"
    And I should not see "Eric"

  Scenario: Update user organization
    When I follow "Edit" within "Eric"
    And I select "BigDeal" from "Organization"
    And I press "Update User"
    Then I should be on admin users page
    And I should see "BigDeal" within "Eric"

  Scenario: Delete user
    When I follow "Delete" within "Eric"
    Then I should be on admin users page
    And I should not see "Eric"
    And 1 member should exist with organization: "Department"

  #drop down menu
  Scenario: Move user
    When I check "Andy"
    And I check "Jane"
    And I follow "BigDeal" within "Move users"
    Then I should be on admin users page
    And I should see "BigDeal" within "Andy"
    And I should see "BigDeal" within "Jane"


  
    