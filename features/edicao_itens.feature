#language: pt

Funcionalidade: Gerenciamento de Itens da Lista
	Para manter a lista sempre atualizada
	Como um membro da lista
	Eu quero adicionar, editar e remover itens

Cenário: Adicionar um novo item
	Dado que estou na página da lista de compras
	Quando eu adiciono "Arroz" à lista
	Então eu devo ver "Arroz" na lista de compras

Cenário: Editar um item existente
    Dado que exista o item "Arroz" na lista
    Quando eu edito "Arroz" para "Arroz Integral"
    Então eu devo ver "Arroz Integral" na lista

Cenário: Remover um item da lista
    Dado que exista o item "Arroz Integral" na lista
    Quando eu removo "Arroz Integral"
    Então eu não devo ver "Arroz Integral" na lista
