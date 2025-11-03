#language: pt

Funcionalidade: Atualização em tempo real
    Como um usuário geral
    Eu quero que as mudanças da lista sejam atualizadas em tempo real
    De forma que a lista possa ser organizada em vários mercados, por exemplo.

Cenário: criar lista
    Dado que estou na página inicial do aplicativo
    E possuo acesso a internet
    Quando eu clicar no botão "Nova Lista"
    Então farei a operação de criar uma nova lista
    Quando terminar a operação de criar uma nova lista
    Então poderei ver o botão "Salvar"
    Quando eu clicar nesse botão
    Então poderei ver a nova lista entre minhas listas

Cenário: apagar lista
    Dado que estou na página inicial do aplicativo
    E possuo acesso a internet
    Quando eu clicar no botão "Apagar Lista"
    Então poderei selecionar uma ou mais das minhas listas
    Então farei a operação de apagar as listas selecionadas
    Quando eu terminar a operação de apagá-las
    Então poderei ver o botão "Salvar"
    Quando eu clicar nesse botão
    Então poderei ver que elas não aparecem entre minhas listas salvas

Cenário: adicionar item
    Dado que estou na página inicial do aplicativo
    E possuo acesso a internet
    Quando eu selecionar uma lista
    Então poderei ver a opção "Novo Item"
    Quando eu clicar nesse botão "Novo Item"
    E eu concluir a operação de criar um novo item
    Então poderei ver o botão "Salvar"
    Quando eu clicar nesse botão
    Então poderei ver o item adicionado a minha lista

Cenário: apagar item
    Dado que estou na página inicial do aplicativo
    E possuo acesso a internet
    Quando eu selecionar uma lista
    Então poderei ver a opção "Deletar Item"
    Quando eu clicar nesse botão "Deletar Item"
    E eu concluir a operação de apagar um item
    Então poderei ver o botão "Salvar"
    Quando eu clicar nesse botão
    Então poderei ver que o item foi apagado da minha lista

Cenário: alterar característica do item
    Dado que estou na página inicial do aplicativo
    E possuo acesso a internet
    Quando eu selecionar uma lista
    Então poderei ver os itens pertencentes a lista
    Quando eu clicar em um dos itens
    Então vou para a página do item cadastrado
    E poderei ver suas informações
    Quando eu clicar em uma das informações
    Então poderei editar a informação selecionada
    E poderei ver o botão "Salvar"
    Quando eu clicar nesse botão
    Então poderei ver a alteração feita no item
