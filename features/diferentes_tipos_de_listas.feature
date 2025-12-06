Feature: Diferentes tipos de listas
  Como um usuário com várias atividades
  Eu quero poder criar listas de diferentes tipos como mercado, viagem
  De forma que diferentes áreas da minha vida se organizem

  Background:
    Given Eu estou logado como usuário

  Scenario: Criar uma lista do tipo mercado
    When Eu visito a página de nova lista
    And Eu preencho "Nome" com "Compras Semanais"
    And Eu seleciono "Mercado" no campo "Tipo"
    And Eu clico em "Criar Lista"
    Then Eu devo ver "Lista criada com sucesso"
    And A lista deve ter o tipo "Mercado"

  Scenario: Criar uma lista do tipo viagem
    When Eu visito a página de nova lista
    And Eu preencho "Nome" com "Viagem para Praia"
    And Eu seleciono "Viagem" no campo "Tipo"
    And Eu clico em "Criar Lista"
    Then Eu devo ver "Lista criada com sucesso"
    And A lista deve ter o tipo "Viagem"

  Scenario: Falha ao criar lista sem tipo
    When Eu visito a página de nova lista
    And Eu preencho "Nome" com "Lista Sem Tipo"
    And Eu clico em "Criar Lista"
    Then Eu devo ver "Tipo é obrigatório"