Dado("que estou na página da lista de compras") do
  visit "/lista"
end

Quando("eu adiciono {string} à lista") do |item|
  fill_in "Novo item", with: item
  click_button "Adicionar"
end

Então("eu devo ver {string} na lista de compras") do |item|
  expect(page).to have_content(item)
end

Dado("que existe o item {string} na lista") do |item|
  visit "/lista"
  fill_in "Novo item", with: item
  click_button "Adicionar"
end

Quando("eu edito {string} para {string}") do |item_antigo, item_novo|
  within(:xpath, "//li[contains(.,'#{item_antigo}')]") do
    click_link "Editar"
  end
  fill_in "Nome do item", with: item_novo
  click_button "Salvar"
end

Então("eu removo {string}") do |item|
  within(:xpath, "//li[contains(.,'#{item}')]") do
    click_link "Remover"
  end
end

Então("eu não devo ver {string} na lista") do |item|
  expect(page).not_to have_content(item)
end
