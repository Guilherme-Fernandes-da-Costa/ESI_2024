Dado("que estou na página {string} para a lista {string}") do |nome_pagina, nome_lista|
  @lista = List.find_by(name: nome_lista)
  visit share_list_path(@lista)
  expect(page).to have_content(nome_pagina)
  expect(page).to have_content(nome_lista)
end

Dado("que estou na página {string}") do |nome_pagina|
  visit share_lists_path
  expect(page).to have_content(nome_pagina)
end

Quando("preencho o nome com {string}") do |nome|
  fill_in 'Nome completo', with: nome
  @nome_convidado = nome
end

Quando("preencho o email com {string}") do |email|
  fill_in 'Email', with: email
  @email_convidado = email
end

Quando("seleciono a permissão {string}") do |permissao|
  select permissao, from: 'Permissão'
end

Quando("clico em {string}") do |texto_botao|
  click_button texto_botao
end

Então("devo ver a mensagem {string}") do |mensagem_esperada|
  expect(page).to have_content(mensagem_esperada)
end

Então("devo ver o nome {string} na lista de pessoas convidadas") do |nome|
  within '.lista-convidados' do
    expect(page).to have_content(nome)
  end
end

Então("não devo ver o nome {string} na lista de pessoas convidadas") do |nome|
  within '.lista-convidados' do
    expect(page).not_to have_content(nome)
  end
end