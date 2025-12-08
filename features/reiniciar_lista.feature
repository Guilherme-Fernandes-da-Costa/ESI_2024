#language:pt

Funcionalidade: reiniciar lista
    Para que a lista tenha os itens desejados e na quantidade certa ou 
    Como um organizador
    Eu quero reiniciar a lista
    
Cenário: Reiniciar uma lista não compartilhada
    Dado que "Maria" é um organizador
    Quando "Maria" apertar no botão "Reiniciar"
    Então a lista deve aparecer vazia (sem itens).

Cenário: Reiniciar uma lista compartilhada
    Dado que "Maria" é um organizador
    Quando "Maria" apertar no botão "Reiniciar"
    Então a lista deve aparecer vazia (sem itens) para todas as pessoas que compartilham essa lista.

Cenário: Pessoa não autorizada reinicia um lista compartilhada
    Dado que "Pedro" não é um organizador
    Quando "Pedro" apertar no botão "Reiniciar"
    Então deve aparecer um pop-up de "Falta de permissão" e a lista se mantem como está.