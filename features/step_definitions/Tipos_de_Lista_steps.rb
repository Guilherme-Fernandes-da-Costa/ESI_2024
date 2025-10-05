Given("I am on the {string} page") do |page_name|
  visit new_list_path
  expect(page).to have_content(page_name)
end

When("I select list type {string}") do |list_type|
  select list_type, from: 'Tipo de Lista'
end

When("I enter list name {string}") do |list_name|
  fill_in 'Nome da Lista', with: list_name
  @current_list_name = list_name
end

When("I add categories {string}") do |categories|
  categories_array = categories.split(', ')
  categories_array.each do |category|
    fill_in 'Nova Categoria', with: category.strip
    click_button 'Adicionar Categoria'
  end
end

When("I click {string}") do |button_text|
  click_button button_text
end

Then("I should see message {string}") do |message|
  expect(page).to have_content(message)
end

Then("I should see {string} in my {string} lists") do |list_name, list_type|
  within "##{list_type.downcase}-lists" do
    expect(page).to have_content(list_name)
  end
end