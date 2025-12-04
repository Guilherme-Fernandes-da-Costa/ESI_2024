# features/step_definitions/remover_lista_amigos_steps.rb

# Given step for user is defined elsewhere to avoid ambiguous matches

# The generic "apertar no botão" step is defined in adicionar_lista_amigos_steps.rb
# to avoid ambiguous matches across friend-management step files.

Então('se ele existir na lista, deve ser removido da sua lista de amigos.') do
  expect(@acao_remover).to be_truthy
  # Simula a remoção de um amigo existente
  amigo = 'Amigo1'
  expect(@lista_amigos).to include(amigo)
  @lista_amigos.delete(amigo)
  expect(@lista_amigos).not_to include(amigo)
  expect(page).to have_content('Amigo removido com sucesso')
end

Então('se ele não existir na lista, um pop-up com mensagem de erro aparecerá.') do
  expect(@acao_remover).to be_truthy
  # Simula tentativa de remover um amigo inexistente
  amigo = 'AmigoInexistente'
  expect(@lista_amigos).not_to include(amigo)
  expect(page).to have_content('Erro: Amigo não encontrado na lista')
end