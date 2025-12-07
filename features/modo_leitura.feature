#language: pt

Funcionalidade: Modo de leitura
	Como um usuário geral
	Eu quero uma opção de 'modo leitura'
	Para que seja mais fácil e simples ler as listas

Cenário: Ativar modo de leitura em uma lista
	Dado que estou visualizando uma lista de compras
	Quando eu clico no botão "Modo Leitura"
	Então a lista deve ser exibida com fonte maior
	E o contraste deve ser aumentado
  

Cenário: Desativar modo de leitura
	Dado que estou no modo de leitura
	Quando eu clico no botão "Modo Normal"
	Então a lista deve voltar ao formato original
    
