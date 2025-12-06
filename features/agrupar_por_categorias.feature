#language: pt

Funcionalidade: Agrupar itens por categoria
    Como um usuário que gosta de comprar por categoria
    Eu quero poder organizar minha lista por categoria como (frios, horti-fruit, carne)
    De forma que possa organizar meus carrinhos de compra

    Cenário: aplicar tags aos itens da lista
        Dado que um novo item "Leite" será adicionado a minha lista 
        Quando eu clicar na opção opcional "Categoria"
        Então aparecerá uma lista de "tags" pré-cadastradas
        Mas se não selecionar o campo "Categoria" o cadastro prossegue normalmente
        Quando eu clicar em uma dessas "tags"
        Então ela será aplicada ao item
        Mas se não selecionar uma tag o cadastro prossegue normalmente
        E eu deveria poder ver essa tags sendo exibida na lista ao lado do nome do item 

    Cenário: ordenar itens pelo campo tag
        Dado que eu estou na página de exibição da minha lista
        Quando eu clicar no campo botão "Ordenar Lista"
        Então eu deveria ver uma lista de opções referentes as tags presentes na lista
        E mais as opções "Agrupar" e "Desagrupar"
        Quando clicar em uma das opções de "tags"
        Então somente serão exibidos os itens que possuem a respectiva "tag"
        Mas se eu clicar na opção "Agrupar"
        Então os itens serão exibidos em ordem alfabética das "tags"
        Mas se eu clicar na opção "Desagrupar"
        Então os itens voltam para suas posições originais anteriores a qualquer ordenação
