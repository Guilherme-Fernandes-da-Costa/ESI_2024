#language: pt

Funcionalidade: Criar Diferentes Tipos de Lista
  Como um usuário com várias atividades
  Eu quero poder criar listas de diferentes tipos como mercado, viagem
  De forma que diferentes áreas da minha vida se organizem

  Cenário: Criar nova lista usando os tipos da lista
    Dado que estou na página "Criar Lista"
    Quando seleciono o tipo de lista "Mercado"
    E preencho o nome da lista com "Compras da Semana"
    E adiciono as categorias "Hortifruti", "Laticínios", "Limpeza"
    E clico em "Salvar Lista"
    Então devo ver a mensagem "Lista criada com sucesso"
    E devo ver "Compras da Semana" nas minhas listas de "Mercado"

  Cenário: Criar lista de compras para viagem
    Dado que estou na página "Criar Lista"
    Quando seleciono o tipo de lista "Viagem"
    E preencho o nome da lista com "Férias na Praia"
    E adiciono as categorias "Roupas", "Documentos", "Higiene"
    E clico em "Salvar Lista"
    Então devo ver a mensagem "Lista criada com sucesso"
    E devo ver "Férias na Praia" nas minhas listas de "Viagem"