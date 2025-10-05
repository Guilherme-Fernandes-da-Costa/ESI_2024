# frozen_string_literal: true
# Implementação dos passos para funcionalidades de Listas e Itens, usando Capybara.

# ------------------------------------
#               DADOS
# ------------------------------------

# Passos de Setup de Ambiente/Usuário
Dado("que eu estou logado no sistema") do
  # NOTA: Em um teste de aceitação real, este DADO deve garantir que um usuário
  # existe no banco de testes e está autenticado. Para simplicidade, simulamos a navegação.
  visit '/home' # Assumindo que '/home' é uma página que exige login
end

Dado("eu estou na página inicial") do
  visit '/'
end

# Setup para o Cenário de Quantidade: Cria a lista navegando e preenchendo
Dado("eu tenho uma lista chamada {string}") do |nome_lista|
  # CAPYBARA: Reutiliza steps de navegação e preenchimento
  visit '/' 
  click_on "Nova Lista"
  fill_in "Nome da Lista", with: nome_lista
  click_button "Salvar"
  
  # Navega para a página da lista recém-criada
  click_link nome_lista
end

# ------------------------------------
#               QUANDO
# ------------------------------------

# Passos de Ação Genéricos (Reutilizáveis)
Quando("eu clicar no botão {string}") do |texto_botao|
  # Clica em botões (ex: "Salvar") ou links/botões (ex: "Nova Lista")
  click_on texto_botao
end

Quando("eu preencher o campo {string} com {string}") do |campo, valor|
  # Preenche campos de formulário (ex: "Email", "Nome da Lista")
  fill_in campo, with: valor
end

# ------------------------------------
#               ENTÃO
# ------------------------------------

# Passos de Verificação Genéricos (Reutilizáveis)
Então("eu devo ver a mensagem {string}") do |mensagem|
  # Verifica se a mensagem de feedback (sucesso/erro) aparece
  expect(page).to have_content(mensagem)
end

# Passos de Verificação Específicos
Então("eu devo ver a lista {string} na página") do |nome_lista|
  # Verifica se o elemento principal do Cenário 1 está visível
  expect(page).to have_content(nome_lista)
end

Então("eu devo ver o texto {string} na lista") do |texto_esperado|
  # Verifica se o item com a quantidade formatada está visível (Cenário 2)
  expect(page).to have_content(texto_esperado)
end