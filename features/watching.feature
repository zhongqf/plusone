Feature: Watching
  In order to provide watching feature
  As a user
  I want start watching and end watching groups
  
  Background:
    Given the following groups exist:
      | name       |
      | Green tree |
    And the following members exist:
      | group      | user    |
      | Green tree | Jessica |
  
  Scenario: Start watching
    Given I logged in as "Lucy"
    When I go to group page which name: "Green tree"
    Then I should see "Watch"
    When I press "Watch"
    Then I should is waching group: "Green tree"
  
  Scenario: End watching
    Given I logged in as "Lucy"
    And I watched group "Green tree"
    When I go to group page which name: "Green tree"
    Then I should see "Unwatch"
    When I press "Unwatch"
    Then I should is not watching group: "Green tree"
  
  Scenario: News updated when watching
    Given I logged in as "Lucy"
    And I watched group "Green tree"
    And wait 1 second
    When somebody start a discussion "New story" in group "Green tree" in background
    And I go to dashboard page
    Then I should see "New story"
  
  Scenario: No update when unwatched
    Given I logged in as "Lucy"
    And I watched group "Green tree"
    And wait 1 second
    And somebody start a discussion "New story" in group "Green tree" in background
    And wait 1 second
    And I unwatched group "Green tree"
    And wait 1 second
    And somebody start a discussion "Refresh" in group "Green tree" in background
    When I go to dashboard page
    Then I should see "New story"
    And I should not see "Refresh"
  
  
  
  
  
  
  
    
  
  
  
