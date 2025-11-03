#feature/sair_lista.feature
#language:pt

@JIRA-ADICIONARLISTAAMIGOS
Funcionalidade: lista de amigos
    Para que facilite a organização de futuras listas 
    Como um usuário
    Eu quero adicionar um usuário numa lista de amigos
    
    Cenário: Adicionar um novo usuario a lista de amigos
        Dado que "Maria" é um usuário
        Quando "Maria" apertar no botão "Adicionar Amigo"
        Então o deve aparecer o cadastro de um amigo para a sua lista, se ele existir será adicionaado a lista

    Cenário: Adicionar novamente um usuario à lista de amigos 
        Dado que "Maria" é um usuário
        Quando "Maria" apertar no botão "Adicionar Amigo"
        Então se na lista já houver esse mesmo usuário, um pop-up com mensagem de erro aparecerá

    Cenário: Adiocionar o próprio usuário à lista de amigos
        Dado que Maria é um usuário
        Quando "Maria" apertar o botão "Adicionar Amigo"
        Então se o usuário a ser adiocionado o usuário de "Maria", um pop-up com mensagem de erro aparecerá