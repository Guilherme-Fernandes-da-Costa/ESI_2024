#language: pt

Funcianalidade: Convidar outras pessoas
	Como um membro de uma família
	Eu quero convidar outras pessoas
	De forma que todos possam contribuir e ver o que está faltando ou já foi comprado


Cenário: Convidar um usuário por email
	Dado Eu estou logado como usuário
	E eu tenho uma lista existente chamada "Lista Compartilhada"
	Quando Eu visito a página da lista "Lista Compartilhada"
	E eu clico em "Convidar Pessoas"
	E eu preencho "Email" com "amigo@example.com"
	E eu clico em "Enviar Convite"
	Então eu devo ver "Convite enviado com sucesso"
	E o usuário convidado deve ser adicionado à lista

Cenário: Ver itens como convidado
	Dado eu estou logado como usuário
	E eu tenho uma lista existente chamada "Lista Compartilhada"
	Dado um usuário convidado está logado
	E ele aceita o convite para "Lista Compartilhada"
	Quando ele visito a página da lista "Lista Compartilhada"
	Então ele deve ver os itens da lista