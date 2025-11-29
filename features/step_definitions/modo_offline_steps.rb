#cenário 1
Dado('que estou na página inicial do aplicativo') do
    @app = App.new
    @app.abrir_pagina_inicial
end

Dado('estou sem conexão com a internet') do
    @app.desativar_internet
    expect(@app.internet_ativa?).to be false
end

Quando('eu clicar na área de acesso às minhas listas') do
    @app.acessar_listas   
end

Então('poderei ver as informações que foram salvas até o último acesso online') do
    listas = @app.obter_listas_salvas
    expect(listas).not_to be_empty
    expect(@app.modo_offline?).to be true
end