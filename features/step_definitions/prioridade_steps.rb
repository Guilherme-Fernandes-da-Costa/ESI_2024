Quando("eu defino a prioridade do item {string} como {string}") do |item, prioridade|
  within(:xpath, "//li[contains(.,'#{item}')]") do
    select prioridade, from: "Prioridade"
    click_button "Salvar"
  end
end

Quando("eu mudo a prioridade do item {string} para {string}") do |item, prioridade|
  within(:xpath, "//li[contains(.,'#{item}')]") do
    select prioridade, from: "Prioridade"
    click_button "Salvar"
  end
end

Então("o item {string} deve aparecer como prioridade {string}") do |item, prioridade|
  within(:xpath, "//li[contains(.,'#{item}')]") do
    expect(page).to have_content("Prioridade: #{prioridade}")
  end
end
