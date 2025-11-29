require 'rails_helper'

RSpec.feature 'Agrupar itens por categoria', type: :feature, js: true do
  let(:user) { create(:user) } 

  background do
    login_as(user, scope: :user) 

    @lista = create(:list, user: user, name: 'Compras da Semana')
    visit list_path(@lista)
  end

  scenario 'aplicar tags aos itens da lista' do
    click_button '+'
    fill_in 'Nome do item', with: 'Leite'
    fill_in 'Quantidade', with: '2'

    click_button 'Categoria' 
    expect(page).to have_css('.category-tags .tag', minimum: 3) 
    find('.tag', text: 'Frios').click

    click_button 'Concluir'

    within('table.items tbody tr', text: 'Leite') do
      expect(page).to have_css('.tag', text: 'Frios')
    end

    click_button '+'
    fill_in 'Nome do item', with: 'Arroz'
    fill_in 'Quantidade', with: '1'
    click_button 'Concluir' 
    expect(page).to have_content('Arroz')
    within('table.items tbody tr', text: 'Arroz') do
      expect(page).not_to have_css('.tag')
    end
  end

  scenario 'ordenar e filtrar itens pelo campo tag' do
    create(:item, list: @lista, name: 'Queijo',      category: 'Frios')
    create(:item, list: @lista, name: 'Maçã',        category: 'Horti-Fruti')
    create(:item, list: @lista, name: 'Picanha',     category: 'Carnes')
    create(:item, list: @lista, name: 'Sabão em pó', category: nil) 

    visit list_path(@lista)

    click_button 'Ordenar Lista'

    expect(page).to have_content('Frios')
    expect(page).to have_content('Horti-Fruti')
    expect(page).to have_content('Carnes')
    expect(page).to have_content('Agrupar')
    expect(page).to have_content('Desagrupar')

    click_link_or_button 'Frios'

    expect(page).to     have_content('Queijo')
    expect(page).not_to have_content('Maçã')
    expect(page).not_to have_content('Picanha')
    expect(page).not_to have_content('Sabão em pó')

    click_button 'Ordenar Lista'
    click_link_or_button 'Desagrupar'

    expect(page).to have_content('Queijo')
    expect(page).to have_content('Maçã')
    expect(page).to have_content('Picanha')

    click_button 'Ordenar Lista'
    click_link_or_button 'Agrupar'

    page.body.index('Carnes').should < page.body.index('Frios') 
    page.body.index('Frios').should < page.body.index('Horti-Fruti')

    expect(page).to have_css('h3', text: 'Carnes')
    expect(page).to have_css('h3', text: 'Frios')
    expect(page).to have_css('h3', text: 'Horti-Fruti')
  end
end