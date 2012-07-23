Feature: Discussions
  In order to provide discussion feature
  As a user
  I want start, comment, and operate discussion
  
  Background:
    Given I logged in
    And the following discussions exist:
      | title            | body   |
      | First discussion | Bingo  |
      | 2nd discussion   | Boo... |
    And I go to a group home page
  
  Scenario: Start discussion
    When I follow "Start discussion"
    And I fill in the following:
      | Title   | The third discussion |
      | Content | Beego                |
    And I press "Post"
    Then discussion should exist with title: "The third discussion", body: "Beego"
    And I should be on group home page
    And I should see "The third discussion"
  
  Scenario: Start a simple discussion
    When I fill in "Quick post" with "A simple discussion"
    And I press "Post"
    Then discussion should exist with body: "A simple discussion", simple: true
    And I should be on group home page
  
  Scenario: View discussion
    When I follow "First discussion"
    Then I should be on discussion page
    And I should see "First discussion"
    And I should see "Bingo"
  
  Scenario: Comment on discussion
    When I follow "First discussion"
    And I fill in "Your comment" with "Great!"
    And I press "Post comment"
    Then comment should exist with body: "Great!"
    And I should be on discussion page
    And I should see "Great!"
  
  
  
  
  
  
  
  
  
