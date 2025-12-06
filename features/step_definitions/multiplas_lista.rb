Dado("que estou na página principal") do
  visit root_path
end

Dado("que tenho {int} listas de compras criadas") do |quantity|
  @user = create(:user)
  @lists = create_list(:shopping_list, quantity, user: @user)
  login_as(@user)
end

Quando("eu clico em {string}") do |element|
  click_link element
end

Quando("eu insiro o nome {string}") do |list_name|
  fill_in 'Nome da lista', with: list_name
end

Quando("confirmo a criação") do
  click_button 'Criar Lista'
end

Quando("eu acesso o menu {string}") do |menu_name|
  find('.lists-dropdown').click
  within '.lists-menu' do
    click_link menu_name
  end
end

Então("devo ver a lista {string} na minha lista de listas") do |list_name|
  within '.my-lists' do
    expect(page).to have_content(list_name)
  end
end

Então("devo ver todas as {int} listas listadas") do |expected_count|
  within '.lists-container' do
    expect(page).to have_css('.list-card', count: expected_count)
  end
end

Então("posso clicar em qualquer lista para visualizá-la") do
  first_list = @lists.first
  within '.lists-container' do
    click_link first_list.name
  end
  expect(current_path).to eq(list_path(first_list))
  expect(page).to have_content(first_list.name)
end
