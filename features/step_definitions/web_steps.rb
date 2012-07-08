require 'uri'
require 'cgi'
#require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end

  def with_css_scope(selector)
    selector = selector.blank? ? nil : selector
    scope = page.find(:css, selector) if selector
    raise "Can't find selector '#{selector}' on page" if selector && !scope
    scope ? yield(scope) : yield(page)
  end
end
World(WithinHelpers)

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )press "([^\"]*)"(?: within "([^\"]*)")?$/ do |button, selector|
  with_scope(selector) do
    click_button(button)
  end
end

When /^(?:|I )press the last "([^\"]*)"(?: within "([^\"]*)")?$/ do |button, selector|
  with_scope(selector) do
    all(:xpath, XPath::HTML.button(button)).last.click
  end
end


When /^(?:|I )follow "([^\"]*)"(?: within "([^\"]*)")?$/ do |link, selector|
  with_scope(selector) do
    click_link(link)
  end
end

When /^(?:|I )fill in "([^\"]*)" with "([^\"]*)"(?: within "([^\"]*)")?$/ do |field, value, selector|
  with_scope(selector) do
    fill_in(field, :with => value)
  end
end

When /^(?:|I )fill in "([^\"]*)" for "([^\"]*)"(?: within "([^\"]*)")?$/ do |value, field, selector|
  with_scope(selector) do
    fill_in(field, :with => value)
  end
end

# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |
#
# TODO: Add support for checkbox, select og option
# based on naming conventions.
#
When /^(?:|I )fill in the following(?: within "([^\"]*)")?:$/ do |selector, fields|
  with_scope(selector) do
    fields.rows_hash.each do |name, value|
      When %{I fill in "#{name}" with "#{value}"}
    end
  end
end

When /^(?:|I )select the following(?: within "([^\"]*)")?:$/ do |selector, fields|
  with_scope(selector) do
    fields.rows_hash.each do |value, name|
      When %{I select "#{name}" from "#{value}"}
    end
  end
end

When /^(?:|I )select "([^\"]*)" from "([^\"]*)"(?: within "([^\"]*)")?$/ do |value, field, selector|
  with_scope(selector) do
    select(value, :from => field)
  end
end

When /^(?:|I )click the element that contain "([^\"]*)"(?: within "([^\"]*)")?$/ do |text, selector|
  with_css_scope(selector) do |node|
    node.find(:xpath,".//*[.='#{text}']").click
  end
end

When /^(?:|I )check "([^\"]*)"(?: within "([^\"]*)")?$/ do |field, selector|
  with_scope(selector) do
    check(field)
  end
end

When /^(?:|I )uncheck "([^\"]*)"(?: within "([^\"]*)")?$/ do |field, selector|
  with_scope(selector) do
    uncheck(field)
  end
end

When /^(?:|I )choose "([^\"]*)"(?: within "([^\"]*)")?$/ do |field, selector|
  with_scope(selector) do
    choose(field)
  end
end

When /^(?:|I )attach the file "([^\"]*)" to "([^\"]*)"(?: within "([^\"]*)")?$/ do |path, field, selector|
  with_scope(selector) do
    attach_file(field, path)
  end
end


When /^(?:|I )bookmark the link "([^\"]*)"(?: within "([^\"]*)")?$/ do |link,selector|
  with_scope(selector) do
    @bookmarked_link = find_link(link)['href']
  end
end

When /^(?:|I )am going to the bookmarked link$/ do
  visit @bookmarked_link
end

Then /^(?:|I )should see JSON:$/ do |expected_json|
  require 'json'
  expected = JSON.pretty_generate(JSON.parse(expected_json))
  actual   = JSON.pretty_generate(JSON.parse(response.body))
  expected.should == actual
end

Then /^(?:|I )should see "([^\"]*)"(?: within "([^\"]*)")?$/ do |text, selector|
  if Capybara.current_driver == Capybara.javascript_driver
    with_css_scope(selector) do
      assert page.has_xpath?(XPath::HTML.content(text), :visible => true)
    end
  elsif page.respond_to? :should
    with_scope(selector) do
      page.should have_content(text)
    end
  else
    with_scope(selector) do
      assert page.has_content?(text)
    end
  end
end

Then /^(?:|I )should see '([^\']*)'(?: within '([^\']*)')?$/ do |text, selector|
  if Capybara.current_driver == Capybara.javascript_driver
    with_scope(selector) do
      assert page.has_xpath?(XPath::HTML.content(text), :visible => true)
    end
  elsif page.respond_to? :should
    with_scope(selector) do
      page.should have_content(text)
    end
  else
    with_scope(selector) do
      assert page.has_content?(text)
    end
  end
end

Then /^(?:|I )should see \/([^\/]*)\/(?: within "([^\"]*)")?$/ do |regexp, selector|
  with_scope(selector) do
    args = ['//*', {
      :text => Regexp.new(regexp),
      :visible => Capybara.current_driver == Capybara.javascript_driver
    }]
    if page.respond_to? :should
      page.should have_xpath(*args)
    else
      assert page.has_xpath?(*args)
    end
  end
end

Then /^I should see "([^\"]*)" only once$/ do |text|
  all(:xpath,"//*[.='#{text}']").size.should == 1
end

Then /^(?:|I )should not see "([^\"]*)"(?: within "([^\"]*)")?$/ do |text, selector|
  if Capybara.current_driver == Capybara.javascript_driver
    with_css_scope(selector) do |scope|
      assert scope.has_no_xpath?("//*[contains(text(), '#{text}')]", :visible => true)
    end
  elsif page.respond_to? :should
    with_scope(selector) do
      page.should have_no_content(text)
    end
  else
    with_scope(selector) do
      assert page.has_no_content?(text)
    end
  end
end

Then /^(?:|I )should not see '([^\']*)'(?: within '([^\']*)')?$/ do |text, selector|
  if Capybara.current_driver == Capybara.javascript_driver
    with_css_scope(selector) do |scope|
      assert scope.has_xpath?(XPath::HTML.content(text), :visible => true)
    end
  elsif page.respond_to? :should
    with_scope(selector) do
      page.should have_no_content(text)
    end
  else
    with_scope(selector) do
      assert page.has_no_content?(text)
    end
  end
end

Then /^(?:|I )should not see \/([^\/]*)\/(?: within "([^\"]*)")?$/ do |regexp, selector|
  with_scope(selector) do
    args = ['//*', {
      :text => Regexp.new(regexp),
      :visible => Capybara.current_driver == Capybara.javascript_driver
    }]
    if page.respond_to? :should
      page.should have_no_xpath(*args)
    else
      assert page.has_no_xpath?(*args)
    end
  end
end




Then /^the "([^\"]*)" field(?: within "([^\"]*)")? should contain "([^\"]*)"$/ do |field, selector, value|
  with_scope(selector) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should
      field_value.should =~ /#{value}/
    else
      assert_match(/#{value}/, field_value)
    end
  end
end

Then /^the "([^\"]*)" field(?: within "([^\"]*)")? should not contain "([^\"]*)"$/ do |field, selector, value|
  with_scope(selector) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should_not
      field_value.should_not =~ /#{value}/
    else
      assert_no_match(/#{value}/, field_value)
    end
  end
end

Then /^the "([^\"]*)" checkbox(?: within "([^\"]*)")? should be checked$/ do |label, selector|
  with_scope(selector) do
    field_checked = find_field(label)['checked']
    if field_checked.respond_to? :should
      field_checked.should be_true
    else
      assert field_checked
    end
  end
end

Then /^the "([^\"]*)" checkbox(?: within "([^\"]*)")? should not be checked$/ do |label, selector|
  with_scope(selector) do
    field_checked = find_field(label)['checked']
    if field_checked.respond_to? :should
      field_checked.should be_false
    else
      assert !field_checked
    end
  end
end

Then /^the "([^"]*)" select should contain the option "([^"]*)"$/ do |selector, value|
  page.has_select?(selector, :options => [value])
end

Then /^the "([^"]*)" select should not contain the option "([^"]*)"$/ do |selector, value|
  !page.has_select?(selector, :options => [value])
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then /^(?:|I )should have the following query string:$/ do |expected_pairs|
  query = URI.parse(current_url).query
  actual_params = query ? CGI.parse(query) : {}
  expected_params = {}
  expected_pairs.rows_hash.each_pair{|k,v| expected_params[k] = v.split(',')} 
  
  if actual_params.respond_to? :should
    actual_params.should == expected_params
  else
    assert_equal expected_params, actual_params
  end
end

Then /^I should get a download with the filename "([^\"]*)"$/ do |filename|
  page.response_headers['Content-Disposition'].should include("filename=\"#{filename}\"")
end

Then /^show me the page$/ do
  save_and_open_page
end

Then /^debugger/ do
  debugger
end

When  /^(?:|I )drag the task list "([^\"]*)" above "([^\"]*)"(?: within "([^\"]*)")?$/ do |dragged_item, dropped_item, selector|
  with_scope(selector) do
    dragged_item = find(:xpath,"//div[@class='task_list']/div[@class='head']/a[.='#{dragged_item}']/..//preceding-sibling::img[@class='drag']")
    dropped_item = find(:xpath,"//*[.='#{dropped_item}']/..//preceding-sibling::img[@class='drag']")
    l1 = dragged_item.native.location
    l2 = dropped_item.native.location
    right = l2.x - l1.x
    down = l2.y - l1.y
    dragged_item.native.drag_and_drop_by right, down - 10
  end
end

When  /^(?:|I )drag the task "([^\"]*)" above "([^\"]*)"(?: within "([^\"]*)")?$/ do |dragged_item, dropped_item, selector|
  with_scope(selector) do
    dragged_item = find(:xpath,"//div[@class='taskName']/a[.='#{dragged_item}']/..//preceding-sibling::*/img[@class='task_drag']")
    dropped_item = find(:xpath,"//*[.='#{dropped_item}']")
    dragged_item.drag_to dropped_item
  end
end

When /^(?:|I )confirm alert message/ do
  page.driver.browser.switch_to.alert.accept
end

When /^(.*) confirming with OK$/ do |main_task|
  if Capybara.current_driver == Capybara.javascript_driver
    page.evaluate_script("window.old_alert = window.alert")
    page.evaluate_script("window.old_confirm = window.confirm")
    page.evaluate_script("window.alert = function(msg) { return true; }")
    page.evaluate_script("window.confirm = function(msg) { return true; }")
  end
  
  When main_task
  
  if Capybara.current_driver == Capybara.javascript_driver
    page.evaluate_script("window.alert = window.old_alert")
    page.evaluate_script("window.confirm = window.old_confirm")
  end
end