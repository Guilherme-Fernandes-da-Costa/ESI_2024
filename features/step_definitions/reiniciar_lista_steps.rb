Dado('que {string} é um organizador') do |nome|
    @organizador = FactoryBot.create(:user, name: nome)
    @lista = FactoryBot.create(:list, owner: @organizador)
    @lista.items << FactoryBot.create_list(:item, 3, list: @lista)
    visit list_path(@lista)
end

Dado('que {string} não é um organizador') do |nome|
    @organizador = FactoryBot.create(:user)
    @usuario = FactoryBot.create(:user, name: nome)
    @lista = FactoryBot.create(:list, owner: @organizador)
    @lista.items << FactoryBot.create_list(:item, 3, list: @lista)
    visit list_path(@lista)
end

Então('a lista deve aparecer vazia \(sem itens).') do
    expect(@lista.items.reload.count).to eq(0)
end

Então('a lista deve aparecer vazia \(sem itens) para todas as pessoas que compartilham essa lista.') do
    expect(@lista.items.reload.count).to eq(0)
end

Então('deve aparecer um pop-up de {string} e a lista se mantem como está.') do |mensagem|
    expect(page).to have_content mensagem
    expect(@lista.items.reload.count).to be > 0
end