Dado("que estou na página da lista de compras") do
    @usuario = FactoryBot.create(:user)
    @lista   = FactoryBot.create(:list, name: "Compras", owner: @usuario)

    visit new_session_path
    fill_in "Email", with: @usuario.email
    fill_in "Senha", with: @usuario.password
    click_button "Entrar"

    visit list_path(@lista)
end

Dado("que exista o item {string} na lista") do |nome|
    @usuario ||= FactoryBot.create(:user)
    @lista   ||= FactoryBot.create(:list, owner: @usuario)

    @item = FactoryBot.create(:item, name: nome, list: @lista)

    visit list_path(@lista)
end

Quando('eu adiciono {string} à lista') do |nome|
    fill_in "Novo item", with: nome
    click_button "Adicionar"
end

Então('eu devo ver {string} na lista de compras') do |nome|
    expect(page).to have_content nome
end

Quando('eu edito {string} para {string}') do |antigo, novo|
    item = @lista.items.find_by(name: antigo)

    within "#item_#{item.id}" do
        click_on "Editar"
    end

    fill_in "Nome", with: novo
    click_button "Salvar"
end

Então('eu devo ver {string} na lista') do |nome|
    expect(page).to have_content nome
end

Quando('eu removo {string}') do |nome|
    item = @lista.items.find_by(name: nome)

    within "#item_#{item.id}" do
        click_on "Remover"
    end
end

Então('eu não devo ver {string} na lista') do |nome|
    expect(page).not_to have_content nome
end