#language: pt

Funcionalidade: Modo Offline
    Como um usuário
    Eu quero acessar minha lista de forma off-line
    De forma que mesmo sem internet eu possa visualizar os itens que estão na lista

Cenário: estando sem internet
    Dado que estou na pagina inicial do aplicativo
    E estou sem internet
    Quando eu clicar na área de acesso as minha listas
    Então poderei ver as informações que foram salvas até quando eu tinha internet
  