# features/step_definitions/login_steps.rb


Dado('que eu sou um usuário cadastrado com email {string} e senha {string}') do |email, senha|
  # Aqui iria o código para criar um usuário no banco de dados de teste.
  # Ex: User.create!(email: email, password: senha, password_confirmation: senha)
  # Usar factories (como FactoryBot) é uma prática comum aqui.
end

Dado('eu visito a página de login') do
  visit '/login'
end

Quando('eu preencho o email com {string} e a senha com {string}') do |email, senha|
  fill_in 'Email', with: email   # O 'Email' deve ser o 'name', 'id' ou 'label' do campo
  fill_in 'Senha', with: senha # O 'Senha' deve ser o 'name', 'id' ou 'label' do campo
end

Quando('eu marco a opção {string}') do |label_do_checkbox|
  check(label_do_checkbox)
end

Quando('clico em {string}') do |nome_do_botao|
  click_button(nome_do_botao)
end

Quando('eu fecho minha sessão') do
  # Capybara.reset_session! é a forma mais eficaz de simular
  # o fechamento e reabertura do navegador, limpando cookies e o estado da sessão.
  Capybara.reset_session!
end

Quando('eu visito a página inicial') do
  visit '/'
end

Então('eu devo ver a mensagem {string}') do |mensagem|
  expect(page).to have_content(mensagem)
end

Então('eu devo ser redirecionado para a página de login') do
  # Verifica se a URL atual corresponde à da página de login.
  expect(current_path).to eq('/login')
end