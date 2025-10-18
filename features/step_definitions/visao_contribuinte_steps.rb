Dado('que existe uma lista chamada {string}') do |list_name|
  @list = List.create!(name: list_name)
end

Dado('que o usuário {string} adicionou o item {string} na lista {string}') do |user_name, item_name, list_name|
  user = User.find_or_create_by!(name: user_name)
  list = List.find_by!(name: list_name)
  list.items.create!(name: item_name, added_by: user)
end

Quando('eu acesso a página da lista {string}') do |list_name|
  visit list_path(List.find_by!(name: list_name))
end

Então('eu devo ver o item {string} com o nome {string}') do |item_name, user_name|
  item = Item.find_by!(name: item_name)
  expect(page).to have_content(item.name)
  expect(page).to have_content(item.added_by.name)
end
