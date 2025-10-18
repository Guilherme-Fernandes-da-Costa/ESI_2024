Dado('que existe uma lista de compras chamada {string}') do |nome_lista|
  @lista = nome_lista
  @itens = []
end

Dado('que {string} adicionou o item {string} à lista') do |autor, item|
  @itens << { nome: item, autor: autor }
end

Dado('que há um item {string} sem autor definido') do |item|
  @itens << { nome: item, autor: nil }
end

Quando('eu visualizar a lista {string}') do |nome_lista|
  expect(@lista).to eq(nome_lista)
  visit "/listas/#{nome_lista.parameterize}" # Exemplo
end

Então('devo ver o item {string} com o autor {string}') do |item, autor|
  expect(@itens.map { |i| i[:nome] }).to include(item)
  expect(page).to have_content(item)
  expect(page).to have_content(autor)
end

Então('devo ver o item {string} com o texto {string}') do |item, texto|
  expect(@itens.map { |i| i[:nome] }).to include(item)
  expect(page).to have_content(item)
  expect(page).to have_content(texto)
end
