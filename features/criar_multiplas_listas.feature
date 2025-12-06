#language: pt

Funcionalidade: criar multiplas listas
    Como um organizador
    Eu quero poder criar multiplas listas
    De forma que seja possível administrar mais de uma lista.

Cenário: criar uma nova lista
    Dado que eu estou na tela de exibição das listas
    E eu vejo um botão "Criar nova lista" abaixo da ultima lista
    Quando eu clicar nesse botão
    Então será reservado um novo slot para essa lista
    E poderei dar o seu respectivo nome

Cenário: adicionar itens a lista
    Dado que eu estou na tela de exibição das listas
    Quando eu clicar eu uma das listas
    Então serei direcionado para uma nova tela
    E poderei ver os itens presentes nela
    Quando clicar no botão com simbolo "+"
    Então poderei ver alguns campos para preencher
    Quando preencher esses campos com as informções do novo item
    E clicar no botão "Concluir"
    Então poderei ver o novo item adicionado a minha lista
    