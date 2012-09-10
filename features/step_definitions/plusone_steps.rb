Then /^pry it/ do
  binding.pry
end

Given /^I logged in as admin$/ do
  email = "admin@plusone.com"
  step 'the following users exist:', table(%{
    | name  | is_admin |
    | admin | true     |
  })
  step 'I go to the login page'
  step 'I fill in "Email" with "'+ email +  '"'
  step 'I fill in "Password" with "papapa"'
  step 'I press "Sign in"'
  
end

When /^I fill the form with name: "(.*?)"$/ do | arg1 |
  pending # express the regexp above with the code you wish you had
end

Given /^no member exist with organization: "(.*?)"$/ do | arg1 |
  pending # express the regexp above with the code you wish you had
end

Then /^I should see 'Department' within "(.*?)"$/ do | arg1 |
  pending # express the regexp above with the code you wish you had
end

Then /^I should see 'BigDeal' within "(.*?)"$/ do | arg1 |
  pending # express the regexp above with the code you wish you had
end

Then /^should can login with name: "(.*?)", password: "(.*?)"$/ do | arg1, arg2 |
  pending # express the regexp above with the code you wish you had
end

Then /^(\d+) member should exist with organization: "(.*?)"$/ do | arg1, arg2 |
  pending # express the regexp above with the code you wish you had
end

Given /^I logged in$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^the following discussions exist:$/ do | table |
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

Then /^discussion should exist with title: "(.*?)", body: "(.*?)"$/ do | arg1, arg2 |
  pending # express the regexp above with the code you wish you had
end

Then /^discussion should exist with body: "(.*?)", simple: true$/ do | arg1 |
  pending # express the regexp above with the code you wish you had
end

Given /^I logged in as "(.*?)"$/ do | user |
  email = user.downcase + "@plusone.com"
  step 'the following users exist:', table(%{
    | name         |
    | } + user + ' | ') 
  step 'I go to the login page'
  step 'I fill in "Email" with "'+ email +  '"'
  step 'I fill in "Password" with "papapa"'
  step 'I press "Sign in"'
end

When /^I fill in the following$/ do | table |
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

Then /^I should be group page which with name: "(.*?)"$/ do | arg1 |
  pending # express the regexp above with the code you wish you had
end

Given /^the following invitation exist:$/ do | table |
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

Given /^the following discussion exist:$/ do | table |
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

Then /^invitation should exist with group: "(.*?)", user : "(.*?)"$/ do | arg1, arg2 |
  pending # express the regexp above with the code you wish you had
end

Then /^invitation should not exist with group: "(.*?)", invitee: "(.*?)"$/ do | arg1, arg2 |
  pending # express the regexp above with the code you wish you had
end

Then /^I should is waching group: "(.*?)"$/ do | arg1 |
  pending # express the regexp above with the code you wish you had
end

Given /^I watched group "(.*?)"$/ do | arg1 |
  pending # express the regexp above with the code you wish you had
end

Then /^I should is not watching group: "(.*?)"$/ do | arg1 |
  pending # express the regexp above with the code you wish you had
end

Given /^wait (\d+) second$/ do | arg1 |
  pending # express the regexp above with the code you wish you had
end

Given /^somebody start a discussion "(.*?)" in group "(.*?)" in background$/ do | arg1, arg2 |
  pending # express the regexp above with the code you wish you had
end

Given /^I unwatched group "(.*?)"$/ do | arg1 |
  pending # express the regexp above with the code you wish you had
end
