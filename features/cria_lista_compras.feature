# features/cria_lista_compras.feature
#language: pt

Funcionalidade: Criação de Lista de Compras
  Para que eu possa organizar meus itens
  Eu, como usuário,
  Gostaria de criar uma nova lista de compras.

  @JIRA-LISTA # Adicione uma tag para rodar este teste especificamente

  Cenário: Usuário cria uma nova lista e ela é exibida
    # DADO: O estado inicial. Vamos assumir que o usuário já está logado.
    Dado que eu estou logado no sistema
    E eu estou na página inicial

    # QUANDO: Ações do usuário. O Capybara vai simular essas ações.
    Quando eu clicar no botão "Nova Lista"
    E preencher o campo "Nome da Lista" com "Lista de Compras da Semana"
    E clicar no botão "Salvar"

    # ENTÃO: O resultado esperado. O Capybara vai verificar.
    Então eu devo ver a mensagem "Lista criada com sucesso!"
    E eu devo ver a lista "Lista de Compras da Semana" na página

@JIRA-QUANTIDADE # Nova tag para esta funcionalidade

Cenário: Usuário adiciona um item especificando a quantidade
  # SETUP: O usuário precisa de uma lista para adicionar o item
  Dado que eu estou logado no sistema
  E eu tenho uma lista chamada "Lista de Compras da Semana"

  # AÇÃO: O usuário interage com a interface
  Quando eu preencher o campo "Item" com "Cerveja"
  E eu preencher o campo "Quantidade" com "12"
  E clicar no botão "Adicionar Item"

  # VERIFICAÇÃO: O resultado esperado
  Então eu devo ver a mensagem "Item adicionado com sucesso!"
  E eu devo ver o texto "Cerveja (12 un.)" na lista