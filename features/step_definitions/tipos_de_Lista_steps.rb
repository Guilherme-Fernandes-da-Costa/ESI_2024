Dado("que estou na página {string}") do |nome_pagina|
  visit new_list_path
  expect(page).to have_content(nome_pagina)
end

Quando("seleciono o tipo de lista {string}") do |tipo_lista|
  select tipo_lista, from: 'Tipo de Lista'
end

Quando("preencho o nome da lista com {string}") do |nome_lista|
  fill_in 'Nome da Lista', with: nome_lista
  @nome_lista_atual = nome_lista
end

Quando("adiciono as categorias {string}") do |categorias|
  array_categorias = categorias.split(',').map(&:strip)
  array_categorias.each do |categoria|
    fill_in 'Nova Categoria', with: categoria
    click_button 'Adicionar Categoria'
  end
end

# Os passos "Quando clico em {string}" e "Então devo ver a mensagem {string}"
# já estão definidos em Compartilhar_Lista_steps.rb, então não precisamos redefinir aqui.

Então("devo ver {string} nas minhas listas de {string}") do |nome_lista, tipo_lista|
  within "##{tipo_lista.downcase}-lists" do
    expect(page).to have_content(nome_lista)
  end
end