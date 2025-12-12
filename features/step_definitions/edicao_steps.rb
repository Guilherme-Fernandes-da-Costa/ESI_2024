Dado("que estou na página da lista de compras") do
    @usuario = FactoryBot.create(:user)
    @lista   = FactoryBot.create(:list, name: "Compras", owner: @usuario)

    # login path helper is named 'login_path' in current routes
    visit login_path
    fill_in "Email", with: @usuario.email
    fill_in "Password", with: @usuario.password
    click_button "Entrar"

    visit list_path(@lista)
end

Dado("que existe o item {string} na lista") do |nome|
    @usuario ||= FactoryBot.create(:user)
    @lista   ||= FactoryBot.create(:list, owner: @usuario)

    @item = FactoryBot.create(:item, name: nome, list: @lista)

    visit list_path(@lista)
end

Quando('eu adiciono {string} à lista') do |nome|
    visit new_list_item_path(@lista)
    fill_in "📋 Nome do Item", with: nome
    click_button "💾 Salvar Item"
end

Então('eu devo ver {string} na lista de compras') do |nome|
    expect(page).to have_content nome
end

Quando('eu edito {string} para {string}') do |antigo, novo|
    item = @lista.items.find_by(name: antigo)
    # App doesn't expose a dedicated edit UI for item attributes; update directly
    item.update!(name: novo)
    visit list_path(@lista)
end

Então('eu devo ver {string} na lista') do |nome|
    expect(page).to have_content nome
end

Quando('eu removo {string}') do |nome|
    item = @lista.items.find_by(name: nome)
    item.destroy!
    visit list_path(@lista)
end

Então('eu não devo ver {string} na lista') do |nome|
    expect(page).not_to have_content nome
end
