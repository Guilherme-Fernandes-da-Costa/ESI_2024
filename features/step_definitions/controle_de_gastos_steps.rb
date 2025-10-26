#cenario 1
Dado("que eu estou na tela de fase de cadastro de um novo item") do
    @list = List.create!(name: "Lista de Compras de Teste")
    visit new_list_item_path(@list)
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
    # SETUP DO CONTEXTO: Garante que uma lista e itens com preços existam para o cálculo.
    @list = List.create!(name: "Lista de Gastos")
    @list.items.create!(name: "Produto 1", preco: 5.00)
    @list.items.create!(name: "Produto 2", preco: 15.50)
    # Visita a rota de exibição da lista
    visit list_path(@list)
end

Então("eu devo poder ver um campo chamado {string} em uma área separada da lista") do |total|
    expect(page).to have_content(total)
end

E("eu devo poder ver o valor total da soma dos itens cadastrados na lista") do
    # Verifica o valor formatado.
    total_esperado = "R$ 20,50" 
    
    expect(page).to have_selector(".valor-total")
    total_texto = find(".valor-total").text
    
    # Garante que a formatação está correta E que o valor é o esperado (20,50)
    expect(total_texto).to match(/R\$ \d+,\d{2}/)
    expect(total_texto).to have_content(total_esperado)
end
