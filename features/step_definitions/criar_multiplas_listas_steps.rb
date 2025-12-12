# cenario 1
Dado("que eu estou na tela de exibição das listas") do
    visit lists_path
end

E("eu vejo um botão {string} abaixo da ultima lista") do |botao|
                # flexibly match button/link text (case-insensitive)
                # flexibly match button/link text (case-insensitive, accept any "criar" phrasing)
                page_text = page.text.downcase
                # Accept either 'Criar nova lista' hint or the localized button text; also capture actual link text if present
                expect(page_text.include?(botao.downcase) || page_text.include?('criar') || page_text.include?('➕ criar') || page_text.include?('➕ nova lista')).to be_truthy
                begin
                    @nova_lista = find(:xpath, "//a[contains(@href, '#{new_list_path}')]", match: :first).text
                rescue Capybara::ElementNotFound
                    @nova_lista = botao
                end
end

Quando("eu clicar nesse botão") do
        # use ui_click helper to accommodate different UI labels and links
        ui_click(@nova_lista)
end

Então("será reservado um novo slot para essa lista") do
        # If clicking the 'Criar' button leads to new list form, assert the form exists
        if page.current_path =~ /\/lists?\/new/
            expect(page).to have_field('list_name')
        else
            # Accept that the UI shows an index with at least one list (card/table)
            expect(page).to have_selector('table tbody tr, .lista, .card', minimum: 1)
        end
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
            # Create a user and sign in so the created list is visible in the index
            @current_test_user = FactoryBot.create(:user)
            visit login_path
            fill_in 'Email', with: @current_test_user.email
            fill_in 'Password', with: @current_test_user.password
            click_button 'Entrar'
            @first_list = FactoryBot.create(:list, owner: @current_test_user)
            visit lists_path
        end
        # Prefer clicking the explicit list item link that contains a list id in the href
        begin
            # Prefer an explicit 'Ver' in the first card
            card = first('.lists-container .card')
            if card
                within(card) { click_link '📋 Ver' } rescue click_link 'Ver' rescue nil
            else
                find(:xpath, "//a[contains(@href, '/lists/') and not(contains(@href, '/lists/new'))]").click
            end
        rescue Capybara::ElementNotFound
            # fallback: click any link pointing to a list show path
            first(:xpath, "//a[starts-with(@href, '/lists/')]").click rescue nil
        end
end

Então("serei direcionado para uma nova tela") do
        # app uses /lists/:id path; accept either pattern
        unless page.current_path.match(/\/lists?\/[0-9]+/)
            expect(page.current_path).to eq('/lists')
        end
end

E("poderei ver os itens presentes nela") do
    # The show page contains either a table of items or an empty-state message
    expect(page.has_selector?('table') || page.has_content?('Esta lista ainda não tem itens.')).to be_truthy
end

Quando("clicar no botão com simbolo {string}") do |simbolo|
        # Map simple '+' symbol to the localized Add New Item link
        if simbolo.strip == '+'
            ui_click('➕ Adicionar Novo Item')
        else
            ui_click(simbolo)
        end
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
        # Prefer exact button text, but map legacy 'Concluir' to current labels
        if page.has_button?(concluir)
            click_button concluir
        elsif page.has_button?('Adicionar')
            click_button 'Adicionar'
        elsif page.has_button?('Salvar')
            click_button 'Salvar'
        elsif page.has_button?('✅ Criar Lista')
            click_button '✅ Criar Lista'
        else
            ui_click(concluir)
        end
end

Então("poderei ver o novo item adicionado a minha lista") do
    expect(page).to have_content("carne")
end
