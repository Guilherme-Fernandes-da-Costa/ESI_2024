#language: pt

Funcionalidade: Marcar itens
    Como uma pessoa no supermercado
    Eu quero marcar itens como “comprados” e vê-los serem riscados
    De forma que todos possam facilmente identificar o que já foi comprado

Cenário: marcar itens comprados
    Dado que exista um item "Leite" na minha lista
    Quando eu clicar em cima do item desejado
    Então aparecerá uma janela com título "Comprado" com as opções: "Marcar" e "Desmarcar"
    Quando apertar o botão correspondente a opção "Marcar"
    Então o item da lista será sobreposto por uma linha
    Mas se a opção "Marcar" já estiver selecionada
    Então não haverá alteração

Cenário: desmarcar itens não comprados
    Dado que exista um item "Leite" na minha lista
    E eu ver que este item está sobre sobreposto por uma linha
    Quando eu clicar em cima do item desejado
    Então aparecerá uma janela com título "Comprado" com as opções: "Marcar" e "Desmarcar"
    Quando apertar o botão correspondente a opção "Desmarcar"
    Então a linha que ficava sobreposta ao item será apagada
    Mas se a opção "Desmarcar" já estiver selecionada
    Então não haverá alteração
