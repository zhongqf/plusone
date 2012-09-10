Feature: Invitations
  In order to invite people to join group
  As a user
  I want create invitation
  
  Background:
    Given the following groups exist:
      | group | name       | is_public |
      | tree  | Green tree | false     |
    And the following users exist:
      | user    | name    |
      | daniel  | Daniel  |
      | jessica | Jessica |
      | tom     | Tom     |
      | eric    | Eric    |
    And the following members exist:
      | user_name | group_name | is_admin |
      | Daniel    | Green tree | true     |
      | Jessica   | Green tree | false    |
    And the following invitation exist:
      | group | user    | invitee |
      | tree  | jessica | eric    |
    And the following discussion exist:
      | group | title             |
      | tree  | Sample discussion |
    And I logged in as "Jessica"
    And I go to group page which name: "Green tree"

  Scenario: Invite member
    When I follow "Members"
    And I follow "Invite people to join"
    And I fill in the following:
      | User | Tom |
    And I press "Invite"
    Then invitation should exist with group: "Green tree", user : "Tom"
  
  Scenario: List group under invitation
    Given I logged in as "Eric"
    When I go to groups page
    Then I should see "Green tree"
    And I should see "Be invited by Jessica"
  
  Scenario: Join group under invitation 
    Given I logged in as "Eric"
    When I go to group page which name: "Green tree"
    Then I should see "Be invited by Jessica"
    And I should see "Join this group"
    When I follow "Join this group"
    Then member should exist with group: "Green tree", user: "Eric"
  
  Scenario: Decline invitation
    Given I logged in as "Eric"
    And I go to group page which name: "Green tree"
    When I follow "Decline"
    Then invitation should not exist with group: "Green tree", invitee: "Eric"
    When I go to groups page
    Then I should not see "Green tree"
  
  Scenario: Only spectator
    Given I logged in as "Eric"
    When I go to group page which name: "Green tree"
    Then I should not see "Quick post"
    When I follow "Sample discussion"
    Then I should not see "Your comment"
  
  
  
  
  
  
  
  
  
  
  
    
