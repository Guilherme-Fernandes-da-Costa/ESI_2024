#language: pt

Funcionalidade: Exibir preços dos itens
    Como alguém preocupado com gastos
    Eu quero acompanhar o valor total da lista
    De forma que possa adicionar os preços estimados aos itens da lista

Cenário: cadastrar novos preços
    Dado que eu estou na tela de fase de cadastro de um novo item
    Quando eu clicar na opção "Preço" referente ao cadastro
    Então eu devo poder adicionar o valor desejado àquele item
    E eu devo poder ver esse valor na lista ao lado do item cadastrado

Cenário: exibir soma total
    Dado que eu estou na tela exibição da minha lista
    Então eu devo poder ver um campo chamado "Total" em uma área separada da lista
    E eu devo poder ver o valor total da soma dos itens cadastrados na lista
    