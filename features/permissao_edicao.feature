# features/permissao_edicao.feature
#language:pt

@JIRA-PERMISSAO
Funcionalidade: Controle de acesso à lista
  Para proteger a lista de alterações não autorizadas
  Como um criador da lista
  Eu quero garantir que apenas pessoas autorizadas possam atualizar a lista

  Cenário: Usuário autorizado edita a lista
    Dado que "Maria" é um usuário autorizado
    Quando "Maria" tenta adicionar "Leite" à lista
    Então a operação deve ser permitida
    E "Leite" deve aparecer na lista

  Cenário: Usuário não autorizado tenta editar a lista
    Dado que "Carlos" é um usuário não autorizado
    Quando "Carlos" tenta adicionar "Pão" à lista
    Então a operação deve ser negada
    E "Pão" não deve aparecer na lista

  Cenário: Apenas usuários autorizados podem remover itens
    Dado que "Ana" é um usuário autorizado
      E "Leite" já está na lista
    Quando "Ana" remove "Leite"
    Então a operação deve ser permitida
      E "Leite" não deve aparecer na lista
