Given('Eu estou logado como usuário') do
    # Assumindo autenticação com Devise ou similar, baseado em estruturas Rails padrão
    user = FactoryBot.create(:user) # Use FactoryBot se configurado nos testes
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_button 'Entrar'
  end

  When('Eu visito a página de nova lista') do
    visit new_list_path
  end

  When('Eu preencho {string} com {string}') do |field, value|
    fill_in field, with: value
  end

  When('Eu seleciono {string} no campo {string}') do |option, field|
    select option, from: field
  end

  When('Eu clico em {string}') do |button|
    click_button button
  end

  Then('Eu devo ver {string}') do |message|
    expect(page).to have_content(message)
  end

  Then('A lista deve ter o tipo {string}') do |kind|
    list = List.last
    expect(list.kind).to eq(kind.downcase) # Assumindo kind como string ou enum
    visit list_path(list)
    expect(page).to have_content("Tipo: #{kind}")
  end
