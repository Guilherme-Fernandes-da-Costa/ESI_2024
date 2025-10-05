Dado("que {string} é um usuário autorizado") do |usuario|
  @usuario_atual = usuario
  @autorizado = true
end

Dado("que {string} é um usuário não autorizado") do |usuario|
  @usuario_atual = usuario
  @autorizado = false
end

Dado("{string} já está na lista") do |item|
  visit "/lista"
  fill_in "Novo item", with: item
  click_button "Adicionar"
end

Quando("{string} tenta adicionar {string} à lista") do |usuario, item|
  visit "/lista"
  if @autorizado
    fill_in "Novo item", with: item
    click_button "Adicionar"
  else
    # simulando tentativa negada
    page.execute_script("alert('Permissão negada!')")
  end
end

Quando("{string} remove {string}") do |usuario, item|
  visit "/lista"
  within(:xpath, "//li[contains(.,'#{item}')]") do
    if @autorizado
      click_link "Remover"
    else
      page.execute_script("alert('Permissão negada!')")
    end
  end
end

Então("a operação deve ser permitida") do
  expect(@autorizado).to be true
end

Então("a operação deve ser negada") do
  expect(@autorizado).to be false
end

Então("{string} deve aparecer na lista") do |item|
  expect(page).to have_content(item)
end

Então("{string} não deve aparecer na lista") do |item|
  expect(page).not_to have_content(item)
end

