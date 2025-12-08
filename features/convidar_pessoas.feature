Feature: Convidar outras pessoas
  Como um membro de uma família
  Eu quero convidar outras pessoas
  De forma que todos possam contribuir e ver o que está faltando ou já foi comprado

  Background:
    Given Eu estou logado como usuário
    And Eu tenho uma lista existente chamada "Lista Compartilhada"

  Scenario: Convidar um usuário por email
    When Eu visito a página da lista "Lista Compartilhada"
    And Eu clico em "Convidar Pessoas"
    And Eu preencho "Email" com "amigo@example.com"
    And Eu clico em "Enviar Convite"
    Then Eu devo ver "Convite enviado com sucesso"
    And O usuário convidado deve ser adicionado à lista

  Scenario: Ver itens como convidado
    Given Um usuário convidado está logado
    And Ele aceita o convite para "Lista Compartilhada"
    When Ele visito a página da lista "Lista Compartilhada"
    Then Ele deve ver os itens da lista