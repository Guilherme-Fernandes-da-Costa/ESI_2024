#language: pt

Funcionalidade: Múltiplas listas de compra
  Como uma pessoa organizada
  Eu quero ter múltiplas listas de compra
  Para que a visualização e navegação entre elas seja fácil

  Cenário: Criar nova lista de compras
    Dado que estou na página principal
    Quando eu clico em "Nova Lista"
    E insiro o nome "Compras do Mês"
    E confirmo a criação
    Então devo ver a lista "Compras do Mês" na minha lista de listas
    

  Cenário: Navegar entre listas existentes
    Dado que tenho 3 listas de compras criadas
    Quando eu acesso o menu "Minhas Listas"
    Então devo ver todas as 3 listas listadas
    E posso clicar em qualquer lista para visualizá-la