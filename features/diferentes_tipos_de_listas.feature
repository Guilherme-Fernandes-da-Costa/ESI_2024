#language: pt

Funcionalidade: Diferentes tipos de listas
	Como um usuário com várias atividades
	Eu quero poder criar listas de diferentes tipos como mercado, viagem
	De forma que diferentes áreas da minha vida se organizem


Cenário: Criar uma lista do tipo mercado
	Quando Eu visito a página de nova lista
	E Eu preencho "Nome" com "Compras Semanais"
	E Eu seleciono "Mercado" no campo "Tipo"
	E Eu clico em "Criar Lista"
	Então Eu devo ver "Lista criada com sucesso"
	E A lista deve ter o tipo "Mercado"

Cenário: Criar uma lista do tipo viagem
	Quando Eu visito a página de nova lista
	E Eu preencho "Nome" com "Viagem para Praia"
	E Eu seleciono "Viagem" no campo "Tipo"
	E Eu clico em "Criar Lista"
	Então Eu devo ver "Lista criada com sucesso"
	E A lista deve ter o tipo "Viagem"

Cenário: Falha ao criar lista sem tipo
	Quando Eu visito a página de nova lista
	E Eu preencho "Nome" com "Lista Sem Tipo"
	E Eu clico em "Criar Lista"
	Então Eu devo ver "Tipo é obrigatório"