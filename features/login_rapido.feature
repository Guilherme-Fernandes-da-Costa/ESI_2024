Funcionalidade: Login Rápido
  Para não precisar digitar minhas credenciais toda vez
  Como um usuário cadastrado
  Eu quero que o sistema se lembre de mim

  Cenário: Usuário é lembrado em uma nova visita
    Dado que eu sou um usuário cadastrado com email "usuario@teste.com" e senha "123456"
    E eu visito a página de login
    Quando eu preencho o email com "usuario@teste.com" e a senha com "123456"
    E eu marco a opção "Lembre de mim"
    E clico em "Entrar"
    E eu fecho minha sessão
    E eu visito a página inicial
    Então eu devo ver a mensagem "Bem-vindo, usuario@teste.com