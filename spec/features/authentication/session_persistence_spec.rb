require 'rails_helper'

RSpec.feature "Session Persistence (Remember Me)", type: :feature do
  let(:user) { create(:user, email: "user@example.com", password: "password") }
  
  scenario "User remains logged in on subsequent visits after checking 'Remember Me'" do
    visit new_user_session_path # Rota página de login
    
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    check 'Lembrar-me' 

    click_button 'Entrar'
    
    expect(page).to have_content 'Login efetuado com sucesso.'
    
    #simula a reabertura do navegador
    Capybara.reset_sessions!

    # Tenta acessar um caminho que só é acessível a usuários logados
    visit root_path 
    
    expect(page).to have_content "Bem-vindo, #{user.email}" 
    expect(page).not_to have_content "Entrar"
  end
end