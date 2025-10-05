Feature: Compartilhar Lista
  Como um membro de uma república
  Eu quero convidar outras pessoas
  De forma que todos possam contribuir e ver o que está faltando ou já foi comprado

  Scenario: Share list with other people
    Given I am on the "Compartilhar Lista" page for "Compras da República"
    When I fill name with "Daniel"
    And I fill email with "danielye3317@gmail.com"
    And I select permission "Editar"
    And I click "Convidar"
    Then I should see message "Convite enviado com sucesso"
    And I should see name "Daniel" in the shared people list