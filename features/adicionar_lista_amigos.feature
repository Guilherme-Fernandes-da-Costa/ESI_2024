#language:pt

Funcionalidade: lista de amigos
    Para que facilite a organização de futuras listas 
    Como um usuário
    Eu quero adicionar um usuário numa lista de amigos
    
    Cenário: Adicionar um novo usuario a lista de amigos
        Dado que "Maria" é um usuário
        Quando "Maria" apertar no botão "Adicionar Amigo"
        Então o deve aparecer o cadastro de um amigo para a sua lista
