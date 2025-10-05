# features/prioridade_itens.feature
#language: pt

Funcionalidade: Definir prioridade nos itens
  Para organizar a compra de acordo com a importância
  Como um ambulante
  Eu quero definir prioridade (alta, média, baixa) nos itens da lista

  Cenário: Definir prioridade alta para um item
    Dado que existe o item "Arroz" na lista
    Quando eu defino a prioridade do item "Arroz" como "Alta"
    Então o item "Arroz" deve aparecer como prioridade "Alta"

  Cenário: Alterar prioridade de um item
    Dado que o item "Arroz" está com prioridade "Alta"
    Quando eu mudo a prioridade do item "Arroz" para "Média"
    Então o item "Arroz" deve aparecer como prioridade "Média"
