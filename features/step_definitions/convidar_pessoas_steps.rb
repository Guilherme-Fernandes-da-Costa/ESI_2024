
Dado("eu estou logado como usuário") do
    @usuario = FactoryBot.create(:user)   

    visit new_session_path
    fill_in "Email", with: @usuario.email
    fill_in "Senha", with: @usuario.password
    click_button "Entrar"
end

Dado("eu tenho uma lista existente chamada {string}") do |nome|
    @lista = FactoryBot.create(:list, name: nome, owner: @usuario)
end

Quando("Eu visito a página da lista {string}") do |nome|
    lista = List.find_by(name: nome)
    visit list_path(lista)
end

Quando("eu clico em {string}") do |botao|
    click_on botao
end

Quando('eu preencho {string} com {string}') do |campo, valor|
    fill_in campo, with: valor
end

Então('eu devo ver {string}') do |mensagem|
    expect(page).to have_content mensagem
end

Então("o usuário convidado deve ser adicionado à lista") do
    expect(@lista.shared_users.count).to be >= 1
end

Dado("um usuário convidado está logado") do
    @convidado = FactoryBot.create(:user)

    visit new_session_path
    fill_in "Email", with: @convidado.email
    fill_in "Senha", with: @convidado.password
    click_button "Entrar"
end

Dado("ele aceita o convite para {string}") do |nome_lista|
    lista = List.find_by(name: nome_lista)
    lista.shared_users << @convidado
end

Quando("ele visito a página da lista {string}") do |nome|
    lista = List.find_by(name: nome)
    visit list_path(lista)
end

Então("ele deve ver os itens da lista") do
    lista = List.find(@lista.id)
    lista.items.each do |item|
        expect(page).to have_content item.name
    end
end