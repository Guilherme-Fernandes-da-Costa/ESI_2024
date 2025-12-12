Quando('{string} apertar no botão {string}') do |nome, botao|
  expect(@usuario).to eq(nome)
  expect(botao).to eq('Adicionar Amigo')
  @acao_adicionar = true
end