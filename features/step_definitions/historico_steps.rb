Dado('que estou na tela de exibição das listas') do
  	visit '/listas' 
  	expect(page).to have_content('Minhas Listas')
end

Quando('eu clicar na lista {string}') do |nome_lista|
  	click_on nome_lista
end

Então('poderei ver seus itens exibidos') do
  	expect(page).to have_selector('.item-lista') 
end

Então('poderei ver um botão {string}') do |botao|
  	expect(page).to have_button(botao)
end

Quando('eu clicar no botão {string}') do |botao|
  	click_on botao
end

Então('poderei ver uma lista das ações feitas nessa lista') do
  	expect(page).to have_content('Histórico de Ações')
end

Então('poderei ver os itens com Status, Data, Usuário e ação realizada') do
  	within('#historico') do
    	expect(page).to have_content('Status')
    	expect(page).to have_content('Data')
    	expect(page).to have_content('Usuário')
    	expect(page).to have_content('Ação')
  	end
end