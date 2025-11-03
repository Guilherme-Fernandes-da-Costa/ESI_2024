#language: pt

Funcionalidade: historico
    Como um usuário
    Eu quero saber quem comprou, adicionou ou alterou cada item
    De forma que consultar um histórico de alterações na lista

Funcionalidade: historico
    Como um usuário
    Eu quero saber quem comprou, adicionou ou alterou cada item
    De forma que consultar um histórico de alterações na lista

Esquema do Cenário: saber quem realizou a ação no item
    Dado que eu estou na tela de exibição das listas
    Quando eu clicar na lista Casa
    Então eu poderei ver seus itens exibidos
    E poderei ver um botão Historico
    Quando eu clicar no botão Historico
    Então poderei ver uma lista das ações feitas nessa lista
    E poderei ver os itens com Status, Data, Usuario e ação realizada