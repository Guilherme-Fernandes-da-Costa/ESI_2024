# features/visao_contribuinte.feature
#language:pt

@JIRA-VIEWCONTRIBUTOR
Funcionalidade: Visualizar quem adicionou cada item
  Como alguém organizado
  Quero poder ver quem adicionou cada item
  Para que eu possa ponderar se aquele item faz sentido na lista

  Contexto:
    Dado que existe uma lista chamada "Compras da Semana"
    E que o usuário "Alice" adicionou o item "Bananas" na lista "Compras da Semana"
    E que o usuário "Bob" adicionou o item "Chocolate" na lista "Compras da Semana"

  Cenário: Visualizar a lista com os nomes de quem adicionou
    Quando eu acesso a página da lista "Compras da Semana"
    Então eu devo ver o item "Bananas" com o nome "Alice"
    E eu devo ver o item "Chocolate" com o nome "Bob"
