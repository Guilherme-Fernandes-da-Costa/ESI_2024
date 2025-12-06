Dado("que estou visualizando uma lista de compras") do
  @list = create(:shopping_list, name: "Minha Lista")
  @items = create_list(:list_item, 3, list: @list)
  visit list_path(@list)
end

Dado("que estou no modo de leitura") do
  visit list_path(@list)
  find('#reading-mode-toggle').click
  expect(page).to have_css('.reading-mode-active')
end

Quando("eu clico no botão {string}") do |button_text|
  case button_text
  when "Modo Leitura"
    find('#reading-mode-toggle').click
  when "Modo Normal"
    find('#normal-mode-toggle').click
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
