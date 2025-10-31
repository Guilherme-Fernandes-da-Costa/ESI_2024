#feature/sair_lista.feature
#language:pt

@JIRA-LISTAAMIGOS
Funcionalidade: remover lista de amigos
    Para que facilite o valor doe 
    Como um usuário
    Eu quero ter uma lista de amigos
    
    Cenário: Remover amigo existente em lista
        Dado que "Maria" é um usuário
        Quando "Maria" apertar no botão "Remover Amigo"
        Então se ele existir na lista, deve ser removido da sua lista de amigos
    
    Cenário: Remover amigo inexistente em lista
        Dado que "Maria" é um usuário
        Quando "Maria" apertar no botão "Remover Amigo"
        Então se ele não existir na lista, um pop-up com mensagem de erro aparecerá