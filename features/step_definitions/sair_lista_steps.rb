Dado('que {string} é um usuário') do |nome|
  @usuario = nome
  @lista_aberta = true
end

Quando('{string} apertar no botão {string}') do |nome, botao|
  expect(@usuario).to eq(nome)
  expect(botao).to eq('Sair')
  @lista_aberta = false
end

Então('{string} deve ser direcionado a tela principal') do |nome|
  expect(@usuario).to eq(nome)
  expect(@lista_aberta).to be_falsey
  expect(page).to have_current_path(tela_principal_path)
end