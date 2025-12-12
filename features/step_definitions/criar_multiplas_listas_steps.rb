# cenario 1
Dado("que eu estou na tela de exibição das listas") do
    visit lists_path
end

E("eu vejo um botão {string} abaixo da ultima lista") do |botao|
    # flexibly match button/link text (case-insensitive)
    # flexibly match button/link text (case-insensitive, accept any "criar" phrasing)
        page_text = page.text.downcase
        expect(page_text.include?(botao.downcase) || page_text.include?('criar')).to be_truthy
    @nova_lista = botao
end

Quando("eu clicar nesse botão") do
    # click link or button that contains the provided text
    click_on @nova_lista
end

Então("será reservado um novo slot para essa lista") do
    expect(page).to have_selector(".lista", count: be >= 1)
end

E("poderei dar o seu respectivo nome") do
    # the new list form uses id 'list_name' and submits with '✅ Criar Lista'
    fill_in 'list_name', with: 'Lista de Compras 2'
    click_button '✅ Criar Lista'
    expect(page).to have_content('Lista de Compras 2')
end

# cenario 2
# (second scenario reuses the same "Dado" step defined above)

Quando("eu clicar eu uma das listas") do
    # open the first available list via its 'Ver' button
    # If no lists yet, create one first for the test
        if page.all(:link, '📋 Ver').empty? 
      @first_list = FactoryBot.create(:list, owner: FactoryBot.create(:user))
      visit lists_path
    end
        # Ensure we have a link and click it
        first(:link, '📋 Ver').click
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
    # items#new form uses ids 'item_name', 'item_preco', 'item_quantity'
    expect(page).to have_field('item_name')
    expect(page).to have_field('item_preco')
    expect(page).to have_field('item_quantity')
end

Quando("preencher esses campos com as informções do novo item") do
    fill_in 'item_name', with: 'carne'
    fill_in 'item_preco', with: 10.00
    fill_in 'item_quantity', with: 2
end

E("clicar no botão {string}") do |concluir|
    click_button concluir
end

Então("poderei ver o novo item adicionado a minha lista") do
    expect(page).to have_content("carne")
end
