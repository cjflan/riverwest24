# FIXME WTF why doesn't the default step work
When 'I press "OK" within the new lap form' do
  execute_script "$('#new_lap').submit()"
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I press "(.*?)"$/ do |button|
  click_button button
end

When /^I press and confirm "(.*?)"$/ do |button|
  accept_confirm { click_button button }
end

When "I follow {string}" do |link|
  click_link link
end

When /^I follow and confirm "(.*?)"$/ do |link|
  accept_confirm { click_link link }
end

When "I type {string} into {string}" do |value, field|
  find_field(field).set nil
  find_field(field).send_keys(value)
end

When /^I fill in "(.*?)" with "(.*?)"$/ do |field, value|
  fill_in field, with: value
end

When /^I fill in "(.*?)" with the following:$/ do |field, value|
  fill_in field, with: value
end

When /^I fill in the following:$/ do |fields|
  fields.rows_hash.each do |name, value|
    fill_in name, with: value
  end
end

When "I fill in the following form:" do |table|
  table.fill_in!
end

When /^I select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select value, :from => field
end

When /^I check "(.*?)"$/ do |field|
  check field
end

When /^I uncheck "(.*?)"$/ do |field|
  uncheck field
end

When /^I choose "(.*?)"$/ do |field|
  choose field
end

When /^I attach the file "(.*?)" to "(.*?)"$/ do |path, field|
  attach_file field, "features/support/fixtures/#{path}"
end

Then /^I should see "(.*?)" filled in with "(.*?)"$/ do |field, value|
  find_field(field).value.should == value
end

Then /^I should see "(.*?)"$/ do |text|
  page.should have_content(text)
end

Then /^I should not see "(.*?)"$/ do |text|
  page.should_not have_content(text)
end

Then "I should see the following form:" do |table|
  table.diff! "form"
end

