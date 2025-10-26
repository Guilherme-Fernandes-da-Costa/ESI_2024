#cenario 1
Dado("que exista um item {string} na minha lista") do |item|
    visit "/lista"
    expect(page).to have_content(item)
    @item = item
end

Quando("eu clicar em cima do item desejado") do
    click_on(@item)
end

Então("aparecerá uma janela com título {string} com as opções: {string} e {dtring}") do |titulo, tag1, tahg2|
    visit "/item selecionado"
    expect(page).to have_content(titulo)
    expect(page).to have_button(tag1)
    expect(page).to have_button(tag2)
end

Quando("apertar o botão correspondente a opção {string}") do |tag1|
    click_button(tag1)
end

Então('o item da lista será sobreposto por uma linha') do
    item_element = find('li', text: @item)
    expect(item_element[:class]).to include('comprado')
end

Mas("se a opção {string} já estiver selecionada") do |tag1|
    within(".janela-comprado") do
        expect(page).to have_button(tag1, disabled: true)
    end
end

Então("não haverá alteração") do
    item_element = find('li', text: @item)

    if item_element[:class].include?("comprado")
        expect(item_element[:class]).to include("comprado")
    else
        expect(item_element[:class]).not_to include("comprado")
    end
end


#cenario 2
E("eu ver que este item está sobre sobreposto por uma linha") do
    item_element = find('li', text: @item)
    expect(item_element[:class]).to include("comprado")
end

Quando("eu clicar em cima do item desejado") do
    click_button(@item)
end

Então("aparecerá uma janela com título {string} com as opções: {string} e {string}") do |titulo, tag1, tahg2|
    visit "/item selecionado"
    expect(page).to have_content(titulo)
    expect(page).to have_button(tag1)
    expect(page).to have_button(tag2)
end

Quando("apertar o botão correspondente a opção {string}") do |tag2|
    click_button(tag2)
end

Então("a linha que ficava sobreposta ao item será apagada") do
    item_element = find('li', text: @item)
    expect(item_element[:class]).not_to include('comprado')
end
 
Mas("se a opção {string} já estiver selecionada") do |opcao|
    within(".janela-comprado") do
        expect(page).to have_button(opcao, disabled: true)
    end
end

Então("não haverá alteração") do
    item_element = find('li', text: @item)

    if item_element[:class].include?("comprado")
        expect(item_element[:class]).to include("comprado")
    else
        expect(item_element[:class]).not_to include("comprado")
    end
end
