Dado('que {string} é um usuário') do |nome|
  @usuario = nome
  @lista_amigos = []
end

Quando('{string} apertar no botão {string}') do |nome, botao|
  expect(@usuario).to eq(nome)
  expect(botao).to eq('Adicionar Amigo')
  @acao_adicionar = true
end

Então('deve aparecer o cadastro de um amigo para a sua lista, se ele existir será adicionado à lista') do
  expect(@acao_adicionar).to be_truthy
  amigo = 'NovoAmigo'
  unless @lista_amigos.include?(amigo)
    @lista_amigos << amigo
  end
  expect(page).to have_content('Cadastro de amigo')
  expect(@lista_amigos).to include(amigo)
end

Então('se {string} na lista já houver esse mesmo usuário, um pop-up com mensagem de erro aparecerá.') do |usuario|
  expect(@acao_adicionar).to be_truthy
  amigo = 'AmigoExistente'
  @lista_amigos << amigo
  expect(page).to have_content('Erro: Usuário já está na lista de amigos')
end

Então('se o usuário a ser adiocionado é o usuário de {string}, um pop-up com mensagem de erro aparecerá.') do |nome|
  expect(@acao_adicionar).to be_truthy
  expect(@usuario).to eq(nome)
  expect(page).to have_content('Erro: Não é possível adicionar você mesmo à lista de amigos')
end
