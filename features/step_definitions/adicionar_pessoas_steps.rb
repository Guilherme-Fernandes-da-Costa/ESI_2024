Dado("que {string} é um organizador") do |usuario|
  @usuario_atual = usuario
  @organizador = true
end

Dado("que {string} não é um organizador") do |usuario|
  @usuario_atual = usuario
  @organizador = false
end

Quando("{string} adiciona {string} à lista") do |usuario, participante|
  visit "/lista"
  if @organizador
    fill_in "Nome do participante", with: participante
    click_button "Adicionar participante"
  else
    page.execute_script("alert('Permissão negada!')")
  end
end

Então("{string} deve aparecer como participante da lista") do |participante|
  within(:xpath, "//li[contains(.,'#{participante}')]") do
    expect(page).to have_content(participante)
  end
end

Então("{string} e {string} devem aparecer como participantes da lista") do |p1, p2|
  [p1, p2].each do |participante|
    within(:xpath, "//li[contains(.,'#{participante}')]") do
      expect(page).to have_content(participante)
    end
  end
end

Então("a operação deve ser negada") do
  expect(@organizador).to be false
end

Então("{string} não deve aparecer na lista") do |participante|
  expect(page).not_to have_content(participante)
end
