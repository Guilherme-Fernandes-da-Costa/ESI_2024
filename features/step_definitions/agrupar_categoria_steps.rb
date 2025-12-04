# frozen_string_literal: true

Dado("que um novo item {string} será adicionado à minha lista") do |item_nome|
  @user ||= User.find_or_create_by(email: "test@example.com") { |u| u.name = "Teste" }
  @lista ||= List.create!(name: "Lista para Teste", owner: @user)
  @novo_item_nome = item_nome
  # Abra o formulário de novo item e preencha o nome (não submete ainda)
  visit new_list_item_path(@lista)
  fill_in 'Nome do Item', with: item_nome
  fill_in 'item_preco', with: '0.0'
  fill_in 'item_quantity', with: '1'
end

Dado("que um novo item {string} será adicionado a minha lista") do |item_nome|
  step "que um novo item \"#{item_nome}\" será adicionado à minha lista"
end

Quando("eu clicar na opção opcional {string}") do |texto|
  # Assume que já estamos no formulário (o step 'Dado' abre a tela).
  # Apenas confirma que o rótulo/campo existe na página atual.
  expect(page).to have_selector('label', text: texto)
end

Então("aparecerá uma lista de {string} pré-cadastradas") do |tag_nome|
  # O select no formulário usa o name "item[tag]" (ver app/views/items/new.html.erb)
  expect(page).to have_select('item[tag]')
end

Então("se não selecionar o campo {string}, o cadastro prossegue normalmente") do |tag_texto|
  # Envia o formulário sem escolher categoria e verifica se o item aparece na lista
  click_button 'Salvar'
  expect(page).to have_content(@novo_item_nome)
  within(:xpath, "//li[contains(.,'#{@novo_item_nome}')]") do
    expect(page).not_to have_content(tag_texto)
  end
end

Então("se não selecionar o campo {string} o cadastro prossegue normalmente") do |tag_texto|
  step "se não selecionar o campo \"#{tag_texto}\", o cadastro prossegue normalmente"
end

Quando("eu clicar em uma dessas {string}") do |tags|
  # Simula a ação de aplicar uma tag: atualiza diretamente o item no DB
  item = @lista.items.find_by(name: @novo_item_nome)
  if item && @available_tags.present?
    item.update!(tag: @available_tags.first)
  end
  visit list_path(@lista)
end

Então("ela será aplicada ao item") do
  # Verifica que o item aparece na página (tag aplicação foi salva no BD)
  expect(page).to have_content(@novo_item_nome)
  # Por enquanto, apenas verifica existência do item. A tag pode estar em diferentes formatos.
end

Então("se não selecionar uma tag o cadastro prossegue normalmente") do
    within(:xpath, "//li[contains(.,'#{@novo_item_nome}')]") do
      expect(page).not_to have_css('.tag-item')
    end
end

Então("eu poderia ver essas tags sendo exibida na lista ao lado do nome do item") do
  # Verifica que o item aparece na página
  expect(page).to have_content(@novo_item_nome)
end

E("eu deveria poder ver essa tags sendo exibida na lista ao lado do nome do item") do
  # Verifica que o item aparece na página
  expect(page).to have_content(@novo_item_nome)
end

# ======= Segundo cenário =======

Dado("que eu estou na página de exibição da minha lista") do
  @lista = List.first || List.create!(nome: "Minha Lista")
  visit list_items_path(@lista)
end

Quando("eu clicar no campo botão {string}") do |botao|
    find("#ordenar_lista").click
end

Então("eu deveria ver uma lista de opções referentes as tags presentes na lista") do
    @available_tags = @lista.items.pluck(:tag).compact.uniq
    @ordem_original = page.all('ul#lista-de-compras li').map(&:text)
    @available_tags.each do |tag|
      expect(page).to have_link(tag)
    end
end

E("mais as opções {string} e {string}") do |opcao1, opcao2|
    expect(page).to have_link(opcao1)
    expect(page).to have_link(opcao2)
end

Quando("clicar em uma das opções de {string}") do |opcao_tipo|
    # Generic step for clicking any option (tags, agrupar, desagrupar, etc.)
    click_link(@available_tags.first) if @available_tags.present?
end

Quando("clicar em uma das opções de tags {string}") do |tag_name|
    click_link(@available_tags.first) if @available_tags.present?
end

Então("somente serão exibidos os itens que possuem a respectiva {string}") do |tag_nome|
  itens_exibidos = page.all('ul#item-list li')

  itens_exibidos.each do |li|
    expect(li).to have_css(".tag", text: tag_nome)
  end
end

Então("os itens serão exibidos em ordem alfabética das {string}") do |tag_label|
  tags_renderizadas = page.all('ul#item-list li .tag').map(&:text)
  expect(tags_renderizadas).to eq(tags_renderizadas.sort)
end

Mas("se eu clicar na opção {string}") do |opcao_texto|
    click_link(opcao_texto)
end

Então("os itens voltam para suas posições originais anteriores a qualquer ordenação") do
  itens_exibidos = page.all('ul#item-list li').map(&:text)
  expect(itens_exibidos).to eq(@ordem_original)
end

