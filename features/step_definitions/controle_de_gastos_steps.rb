#cenario 1
Dado("que eu estou na tela de fase de cadastro de um novo item") do
    visit "/cadastro"
end

Quando("eu clicar na opção {string} referente ao cadastro") do |preco|
    click_button preco
end

Então("eu devo poder adicionar o valor desejado àquele item") do
    @produto_preco = 10
    fill_in "Preço", with: @produto_preco
    fill_in "item_name", with: "Maçã"
    click_button "Adicionar"
end

E("eu devo poder ver esse valor na lista ao lado do item cadastrado") do
    visit list_path(@list)
    # Garante que o valor formatado em BRL é exibido (R$ 10,00)
    expect(page).to have_content("R$ 10,00")
end

#cenario 2
Dado("que eu estou na tela exibição da minha lista") do
    visit "/lista"
end

Então("eu devo poder ver um campo chamado {string} em uma área separada da lista") do |total|
    expect(page).to have_content(total)
end

E("eu devo poder ver o valor total da soma dos itens cadastrados na lista") do
    expect(page).to have_selector(".valor-total")
    total_texto = find(".valor-total").text
    expect(total_texto).to match(/R\$ \d+,\d{2}/)
end
