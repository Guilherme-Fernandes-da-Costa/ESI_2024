# features/adicionar_pessoas.feature
#language:pt

@JIRA-ADICIONARPESSOAS
Funcionalidade: Adição de pessoas à lista
  Para que mais pessoas possam contribuir com suas necessidades
  Como um organizador
  Eu quero adicionar participantes à lista

  Cenário: Organizador adiciona uma nova pessoa à lista
    Dado que "Maria" é um organizador
    Quando "Maria" adiciona "João" à lista na unidade "Caixa 1"
    Então "João" deve aparecer como participante da lista na unidade "Caixa 1"

  Cenário: Adicionar várias pessoas
    Dado que "Maria" é um organizador
    Quando "Maria" adiciona "Ana" à lista na unidade "Caixa 2"
      E "Maria" adiciona "Carlos" à lista na unidade "Caixa 2"
    Então "Ana" e "Carlos" devem aparecer como participantes da lista na unidade "Caixa 2"

  Cenário: Pessoa não autorizada tenta adicionar participantes
    Dado que "Pedro" não é um organizador
    Quando "Pedro" tenta adicionar "Lucas" à lista
    Então a operação deve ser negada
    E "Lucas" não deve aparecer na lista
