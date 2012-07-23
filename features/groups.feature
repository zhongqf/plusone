Feature: Groups
  In order to provide group feature
  As a user
  I want create and manage groups
  
  Background:
    Given the following groups exist:
      | name       | public |
      | Group one  | true   |
      | Green tree | false  |
    And the following members exist:
      | user    | group      | is_admin |
      | Andy    | Group one  | true     |
      | Tom     | Group one  | false    |
      | Daniel  | Green tree | true     |
      | Jessica | Green tree | false    |
    And I logged in as "Daniel"
    And I go to group list page
    
  Scenario: List group
    When I logged in as "Andy"
    And I go to group list page
    Then I should see "Group one"
    And I should not see "Green tree"
    When I logged in as "Daniel"
    And I go to group list page
    Then I should see "Group one"
    And I should see "Green tree"
  
  Scenario: List group member
    When I go to group page which with name: "Green tree"
    And I follow "Members"
    Then I should see "Daniel"
    And I should see "Jessica"
    And I should not see "Andy"
  
  Scenario: Create group
    When I follow "Create new group"
    And I fill in the following
      | Name   | Movie star |
      | public | true       |
    And I press "Create"
    Then group should exist with name: "Movie start", public: true
    And I should be group page which with name: "Movie star"

  Scenario: Join group
    Given I logged in as "Jessica"
    And I go to group page which name: "Group one"
    Then I should see "Join this group"
    When I follow "Join this group"
    Then member should exist with group: "Group one", user: "Jessica"
  
  Scenario: Quit group
    Given I logged in as "Jessica"
    And I go to group page which name: "Green tree"
    Then I should see "Quit this group"
    When I follow "Quit this group"
    Then member should not exist with group: "Green tree", user: "Jessica"
    

  
  
  
  
  
  

  
  
  
  
  
  
  
  
  
  
  
  
    
  
  
  
  
