require_relative '../../app/services/criar_multiplas_listas'

#cenario 1
Dado("que eu estou na tela de exibição das listas")do
    visit "/lista"
end

E("eu vejo um botão {string} abaixo da ultima lista") do |botao|
    expect(page).to have_button(botao)
    @nova_lista = botao
end

Quando("eu clicar nesse botão") do
    click_button (@nova_lista)
end

Então("será reservado um novo slot para essa lista") do
    expect(page).to have_selector(".lista", count: be >= 1)
end

E("poderia dar o seu respectivo nome") do
    fill_in "Nome da lista", with: "Lista de Compras 2"
    click_button "Salvar"
    expect(page).to have_content("Lista de Compras 2")
end

#cenario 2
# (second scenario reuses the same "Dado" step defined above)

Quando("eu clicar eu uma das listas") do
    click_on "Listas de Compras"
end

Então("serei direcionado para uma nova tela") do
    expect(page.current_path).to match(/\/lista\/\d+/)
end

E("poderei ver os itens presentes nela") do
    expect(page).to have_selector(".itens-lista")
end

Quando("clicar no botão com simbolo {string}") do |simbolo|
    click_button simbolo
end

Então("poderei ver alguns campos para preencher") do
    expect(page).to have_content("nome")
    expect(page).to have_content("preco")
    expect(page).to have_content("quantidade")
end

Quando("preencher esses campos com as informções do novo item") do
    fill_in "nome", with: "carne"
    fill_in "preco", with: 10.00
    fill_in "quantidade", with: 2
end

E("clicar no botão {string}") do |concluir|
    click_button concluir
end

Então("poderei ver o novo item adicionado a minha lista") do
    expect(page).to have_content("carne")
end
