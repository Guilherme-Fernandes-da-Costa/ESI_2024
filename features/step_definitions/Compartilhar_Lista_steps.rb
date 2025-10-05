Given("I am on the {string} page for {string}") do |page_name, list_name|
  @list = List.find_by(name: list_name)
  visit share_list_path(@list)
  expect(page).to have_content(page_name)
  expect(page).to have_content(list_name)
end

Given("I am on the {string} page") do |page_name|
  visit share_lists_path
  expect(page).to have_content(page_name)
end

When("I fill name with {string}") do |name|
    fill_in 'Nome completo', with: name
    @invited_name = name
end

When("I fill email with {string}") do |email|
  fill_in 'Email', with: email
  @invited_email = email
end

When("I select permission {string}") do |permission|
  select permission, from: 'Permissão'
end

When("I click {string}") do |button_text|
  click_button button_text
end

Then("I should see message {string}") do |expected_message|
  expect(page).to have_content(expected_message)
end

Then("I should see name {string} in the shared people list") do |name|
  within '.lista-convidados' do
    expect(page).to have_content(name)
  end
end

Then("I should not see name {string} in the shared people list") do |name|
  within '.lista-convidados' do
    expect(page).not_to have_content(name)
  end
end