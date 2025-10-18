# features/visualizar_autor_item.feature
#language:pt

@JIRA-VISUALIZAR_AUTOR
Funcionalidade: Visualizar quem adicionou cada item
  Como alguém organizado
  Quero poder ver quem adicionou cada item
  Para que eu possa ponderar se aquele item faz sentido na lista

  Cenário: Exibir o nome do autor ao lado de cada item na lista
    Dado que existe uma lista de compras chamada "Compras da Semana"
    E que "Alice" adicionou o item "Bananas" à lista
    E que "Bob" adicionou o item "Chocolate" à lista
    Quando eu visualizar a lista "Compras da Semana"
    Então devo ver o item "Bananas" com o autor "Alice"
    E devo ver o item "Chocolate" com o autor "Bob"

  Cenário: Indicar quando não há autor registrado
    Dado que existe uma lista de compras chamada "Lista da Feira"
    E que há um item "Uvas" sem autor definido
    Quando eu visualizar a lista "Lista da Feira"
    Então devo ver o item "Uvas" com o texto "Autor desconhecido"
