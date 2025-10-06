#feature/sair_lista.feature
#language:pt

@JIRA-SAIRLISTA
Funcionalidade
    Para voltar a tela principal, estando com a lista aberta 
    Como um usuário
    Eu quero ao apertar o botão "Sair" sair da lista à tela principal
    
    Cenário: Sair de uma lista não compartilhada
        Dado que "Maria" é um usuário
        Quando "Maria" apertar no botão "Sair"
        Então "Maria" deve ser direcionado a tela principal
    
    Cenário: Sair uma lista compartilhada
        Dado que "Maria" é um usuário
        Quando "Maria" apertar no botão "Sair"
        Então "Maria" deve ser direcionado a tela principal