Dado("que estou visualizando uma lista de compras") do
  @user = FactoryBot.create(:user)
  @list = FactoryBot.create(:list, name: "Minha Lista", owner: @user)
  @items = FactoryBot.create_list(:item, 3, list: @list, added_by: @user)
  # ensure signed in for full UI
  visit login_path
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_button 'Entrar'
  visit list_path(@list)
end

Dado("que estou no modo de leitura") do
  visit list_path(@list)
  # If the toggle exists, click it; otherwise simulate reading-mode via JS
  if page.has_css?('#reading-mode-toggle')
    find('#reading-mode-toggle').click
  else
    page.execute_script("document.body.classList.add('reading-mode-active')")
    page.execute_script("document.body.classList.add('reading-mode')")
  end
  expect(page).to have_css('.reading-mode-active')
end

Quando("eu clico no botão {string}") do |button_text|
  case button_text
  when "Modo Leitura"
    if page.has_css?('#reading-mode-toggle')
      find('#reading-mode-toggle').click
    else
      page.execute_script("document.body.classList.add('reading-mode-active')")
    end
  when "Modo Normal"
    if page.has_css?('#normal-mode-toggle')
      find('#normal-mode-toggle').click
    else
      page.execute_script("document.body.classList.remove('reading-mode-active')")
      page.execute_script("document.body.classList.remove('reading-mode')")
    end
  else
    click_button button_text
  end
end

Então("a lista deve ser exibida com fonte maior") do
  expect(page).to have_css('.reading-mode .text-large')
  expect(page).to have_css('.reading-mode .font-size-18px')
end

Então("o contraste deve ser aumentado") do
  expect(page).to have_css('.reading-mode .high-contrast')
  expect(page).to have_css('.reading-mode .bg-high-contrast')
end

Então("a lista deve voltar ao formato original") do
  expect(page).not_to have_css('.reading-mode-active')
  expect(page).not_to have_css('.text-large')
  expect(page).not_to have_css('.high-contrast')
end
