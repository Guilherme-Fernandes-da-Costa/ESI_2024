# cenario 1
Dado("que eu estou na tela de fase de cadastro de um novo item") do
    # create and sign in a user so the created item will have an added_by set
    @user = FactoryBot.create(:user)
    @list = FactoryBot.create(:list, owner: @user)
    visit login_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Entrar"
    visit new_list_item_path(@list)
end

Quando("eu clicar na opção {string} referente ao cadastro") do |preco|
        # The form does not necessarily expose a button called "Preço".
        # Try several strategies: click a button/link, or focus the input field by label or name.
        if page.has_button?(preco)
            click_button preco
        elsif page.has_link?(preco)
            click_link preco
        elsif page.has_field?(preco)
            find_field(preco).click
        elsif page.has_field?('preco')
            find_field('preco').click
        else
            # as a fallback, ensure the preco input exists by name or id
            expect(page).to have_selector("input[name='item[preco]'], input#item_preco")
        end
end

Então("eu devo poder adicionar o valor desejado àquele item") do
    @produto_preco = 10
        # Fill the price field flexibly (label may be localized or not)
        if page.has_field?("Preço")
            fill_in "Preço", with: @produto_preco
        elsif page.has_field?("item_preco")
            fill_in "item_preco", with: @produto_preco
        elsif page.has_field?("item[preco]")
            fill_in "item[preco]", with: @produto_preco
        else
            fill_in "preco", with: @produto_preco
        end
        # Fill name and submit (the new item form uses 'Salvar')
        fill_in "item_name", with: "Maçã"
        click_button "Salvar"
end

E("eu devo poder ver esse valor na lista ao lado do item cadastrado") do
    visit list_path(@list)
    expect(page).to have_content("R$ 10,00")
end

# cenario 2
Dado("que eu estou na tela exibição da minha lista") do
    user = FactoryBot.create(:user)
    @list = FactoryBot.create(:list, name: "Lista de Gastos", owner: user)
    @list.items.create!(name: "Produto 1", preco: 5.00, added_by: user)
    @list.items.create!(name: "Produto 2", preco: 15.50, added_by: user)
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Entrar"
    visit list_path(@list)
end

Então("eu devo poder ver um campo chamado {string} em uma área separada da lista") do |total|
    # Accept case-insensitive presence of the label (UI shows 'Totais' in some pages)
    expect(page.text.downcase).to include(total.downcase)
end

E("eu devo poder ver o valor total da soma dos itens cadastrados na lista") do
    total_esperado = "R$ 20,50"

    expect(page).to have_selector(".valor-total")
    total_texto = find(".valor-total").text

    expect(total_texto).to match(/R\$ \d+,\d{2}/)
    expect(total_texto).to have_content(total_esperado)
end
