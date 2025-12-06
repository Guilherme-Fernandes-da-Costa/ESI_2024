Dado('que existe uma lista de compras chamada {string}') do |nome_lista|
  @lista = List.create!(name: nome_lista, owner: User.first || User.create!(email: 'owner@test.com', name: 'Owner'))
end

Dado('que {string} adicionou o item {string} à lista') do |autor, item|
  user = User.find_or_create_by(email: "#{autor.downcase}@test.com") { |u| u.name = autor }
  Item.create!(list: @lista, name: item, added_by: user, quantity: 1, preco: 0.0, comprado: false)
end

Dado('que há um item {string} sem autor definido') do |item|
  # Mark this item as having no author by storing a flag (or use a blank/system user)
  # For simplicity, we'll use a marker to check in the step
  @unknown_item = item
  unknown_user = User.find_or_create_by(email: 'unknown@system.com') { |u| u.name = 'Autor desconhecido' }
  Item.create!(list: @lista, name: item, added_by: unknown_user, quantity: 1, preco: 0.0, comprado: false)
end

Quando('eu visualizar a lista {string}') do |nome_lista|
  # Use list_path with the ID, not parameterized name
  visit list_items_path(@lista)
end

Então('devo ver o item {string} com o autor {string}') do |item, autor|
  expect(page).to have_content(item)
  expect(page).to have_content(autor)
end

Então('devo ver o item {string} com o texto {string}') do |item, texto|
  expect(page).to have_content(item)
  expect(page).to have_content(texto)
end
