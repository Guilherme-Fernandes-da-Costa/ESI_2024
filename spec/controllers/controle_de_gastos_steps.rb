require 'rails_helper'

RSpec.feature 'Exibir preços dos itens', type: :feature, js: true do
  let(:user)  { create(:user) }
  let(:lista) { create(:list, user: user, name: 'Compras do Mês') }

  background do
    login_as(user, scope: :user)
    visit list_path(lista)
  end

  scenario 'cadastrar novos preços ao adicionar item' do
    click_button '+'

    expect(page).to have_field('Nome do item')

    fill_in 'Nome do item',     with: 'Arroz 5kg'
    fill_in 'Quantidade',       with: '3'

    fill_in 'Preço', with: '24.90'   

    click_button 'Concluir'

    within('table.items tbody tr', text: 'Arroz 5kg') do
      expect(page).to have_content('R$ 24,90')   
      expect(page).to have_content('3 × R$ 24,90') 
    end
  end

  scenario 'exibir soma total da lista' do
    create(:item, list: lista, name: 'Leite Integral',   price_cents: 499)  
    create(:item, list: lista, name: 'Pão de Forma',     price_cents: 899)  
    create(:item, list: lista, name: 'Sabão em Pó 1kg',  price_cents: 1590, quantity: 2) 

    visit list_path(lista)

    expect(page).to have_css('.total-section', text: 'Total')
    expect(page).to have_css('#total-value')

  
    expect(page).to have_content('R$ 45,78')
      .or have_content('45,78')   

    create(:item, list: lista, name: 'Tomate', price_cents: nil)
    visit list_path(lista)

    expect(page).to have_content('R$ 45,78')
  end

  scenario 'atualização do total em tempo real ao adicionar preço', js: true do
    click_button '+'
    fill_in 'Nome do item', with: 'Açúcar'
    fill_in 'Quantidade',   with: '1'

    expect(page).to have_content('R$ 0,00')

    fill_in 'Preço', with: '12.50'
    click_button 'Concluir'

    expect(page).to have_content('R$ 12,50')
  end
end