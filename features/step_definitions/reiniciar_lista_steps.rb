Dado('que {string} é um organizador') do |nome|
    @organizador = FactoryBot.create(:user, name: nome)
    @lista = FactoryBot.create(:list, owner: @organizador)
    @lista.items << FactoryBot.create_list(:item, 3, list: @lista, added_by: @organizador)
    # sign in as the organizer so the reiniciar controls are visible
    visit login_path
    fill_in 'Email', with: @organizador.email
    fill_in 'Password', with: @organizador.password
    click_button 'Entrar'
    visit list_path(@lista)
end

Dado('que {string} não é um organizador') do |nome|
    @organizador = FactoryBot.create(:user)
    @usuario = FactoryBot.create(:user, name: nome)
    @lista = FactoryBot.create(:list, owner: @organizador)
    @lista.items << FactoryBot.create_list(:item, 3, list: @lista, added_by: @organizador)
    # sign in as the non-organizer user
    visit login_path
    fill_in 'Email', with: @usuario.email
    fill_in 'Password', with: @usuario.password
    click_button 'Entrar'
    visit list_path(@lista)
end

# Avoid matching the 'Adicionar Amigo' step which has a specific implementation
Quando(/^"([^"]+)" apertar no botão "(?!Adicionar Amigo)(.+)"$/) do |nome, botao|
        # Map legacy 'Reiniciar' label to current UI '🔄 Reiniciar Lista'
        if botao =~ /reiniciar/i
            if page.has_button?('🔄 Reiniciar Lista')
                click_button '🔄 Reiniciar Lista'
            elsif page.has_button?('Reiniciar Lista')
                click_button 'Reiniciar Lista'
            else
                click_on botao
            end
        else
            click_on botao
        end
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