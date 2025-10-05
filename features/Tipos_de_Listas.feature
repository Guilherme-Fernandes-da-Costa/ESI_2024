Feature: Criar Diferentes Tipos de Lista
  Como um usuário com várias atividades
  Eu quero poder criar listas de diferentes tipos como mercado, viagem
  De forma que diferentes áreas da minha vida se organizem

  Scenario: Criar nova lista usando os tipos da lista
    Given I am on the "Criar Lista" page
    When I select list type "Mercado"
    And I enter list name "Compras da Semana"
    And I add categories "Hortifruti", "Laticínios", "Limpeza"
    And I click "Salvar Lista"
    Then I should see message "Lista criada com sucesso"
    And I should see "Compras da Semana" in my "Mercado" lists