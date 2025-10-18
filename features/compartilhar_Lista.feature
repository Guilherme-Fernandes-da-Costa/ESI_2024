Funcionalidade: Compartilhar Lista
  Como um membro de uma república
  Eu quero convidar outras pessoas
  De forma que todos possam contribuir e ver o que está faltando ou já foi comprado

  Cenário: Compartilhar lista com outra pessoa
    Dado que estou na página "Compartilhar Lista" para a lista "Compras da República"
    Quando preencho o nome com "Daniel"
    E preencho o email com "danielye3317@gmail.com"
    E seleciono a permissão "Editar"
    E clico em "Convidar"
    Então devo ver a mensagem "Convite enviado com sucesso"
    E devo ver o nome "Daniel" na lista de pessoas convidadas

  Cenário: Compartilhar lista com e-mail inválido
    Dado que estou na página "Compartilhar Lista"
    Quando preencho o nome com "Carlos"
    E preencho o email com "email-invalido"
    E clico em "Convidar"
    Então devo ver a mensagem "Email inválido"
    E não devo ver o nome "Carlos" na lista de pessoas convidadas