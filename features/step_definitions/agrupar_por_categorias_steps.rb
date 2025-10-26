#cenario 1
Dado("que um novo item {string} será adicionado a minha lista") do |item|
   @lista ||= Lista.first || Lista.create!(nome: "Minha Lista")

  visit new_lista_item_path(@lista)
  fill_in "Novo item", with: item_name
  click_button "Adicionar"

  @coisa = item_name
end

Quando('eu clicar na opção opcional {string}') do |label|
  @tag_select = find_field(label)
  expect(@tag_select).to be_present
end

Então("aparecerá uma lista de {string} pré-cadastradas") do |tags|
    expect(page).to have_content(tags)
end

Mas("se não selecionar o campo {string} o cadastro prossegue normalmente") do |categorias|
    click_button 'Adicionar'
    expect(Item.last.tag).to be_nil
    expect(page).to have_content(@coisa)
end

Quando("eu clicar em uma dessas {string}") do |tag|
  check(tag)
  @tag_selecionada = tag
end

Então("ela será aplicada ao item") do
    within(:xpath, "//li[contains(.,'#{@coisa}')]") do
        expect(page).to have_content(@tag_selecionada)
    end
end

Mas("se não selecionar uma tag o cadastro prossegue normalmente") do
    visit "/lista"
    expect(page).to have_content(@coisa)
end

E("eu deveria poder ver essa tags sendo exibida na lista ao lado do nome do item") do
    within(:xpath, "//li[contains(.,'#{@coisa}')]") do
        expect(page).to have_content(@tag_selecionada)
    end
end


#cenario 2
Dado("que eu estou na página de exibição da minha lista") do
   @lista ||= Lista.first || Lista.create!(nome: "Minha Lista") 
   visit "/lista"
end

Quando("eu clicar no campo botão {string}") do |ord_list|
    click_button ord_list
    @botao_ord = ord_list
end

Então("eu deveria ver uma lista de opções referentes as tags presentes na lista") do
    expect(page).to have_selector(".opcoes-tags")
end

E("mais as opções {string} e {string}") do |agrupar, desagrupar|
    expect(page).to have_content(agrupar)
    expect(page).to have_content(desagrupar)
end

Quando("clicar em uma das opções de {string}") do |tags|
    click_button tags
    @tag_escolhida = tags
end

Então("somente serão exibidos os itens que possuem a respectiva {string}") do |tag|
    all("li").each do |li|
        expect(li.text).to include(tag)
    end
end

Mas("se eu clicar na opção {string}") do |agrupar|
    click_on agrupar
    @agrupar = agrupar
end

Então("os itens serão exibidos em ordem alfabética das {string}") do |tags|
    tags_na_pagina = all(".item-tag").map(&:text)
    expect(tags_na_pagina).to eq(tags_na_pagina.sort)
end

Mas("se eu clicar na opção {string}") do |desagrupar|
    click_on desagrupar
end

Então("os itens voltam para suas posições originais anteriores a qualquer ordenação") do
    expect(page).to have_content(@coisa)
end
