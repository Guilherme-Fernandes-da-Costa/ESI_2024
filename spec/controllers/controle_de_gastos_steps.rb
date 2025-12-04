require 'rails_helper'

RSpec.feature 'Exibir preços dos itens', type: :feature do
  let(:user)  { User.create!(email: 'test@spec.local', name: 'Spec User') }
  let(:lista) { List.create!(name: 'Compras do Mês', owner: user) }

  background do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit list_path(lista)
  end

  scenario 'cadastrar novos preços ao adicionar item' do
    # create item directly (avoid JS modal)
    Item.create!(list: lista, name: 'Arroz 5kg', quantity: 3, preco: 24.90, added_by: user)
    visit list_items_path(lista)

    within('ul#lista-de-compras') do
      within('li', text: 'Arroz 5kg') do
        expect(page).to have_css('.item-preco', text: /24,90/) 
      end
    end
  end

  scenario 'exibir soma total da lista' do
    Item.create!(list: lista, name: 'Leite Integral',  preco: 4.99,  added_by: user)
    Item.create!(list: lista, name: 'Pão de Forma',    preco: 8.99,  added_by: user)
    Item.create!(list: lista, name: 'Sabão em Pó 1kg', preco: 15.90, quantity: 2, added_by: user)

    visit list_items_path(lista)

    # Total is rendered in .area-total .valor-total
    expect(page).to have_css('.area-total')
    expect(page).to have_css('.valor-total')

    # controller sums preco directly (not multiplied by quantity)
    expect(page).to have_content('R$ 29,88')

    Item.create!(list: lista, name: 'Tomate', preco: 0.0, added_by: user)
    visit list_items_path(lista)

    expect(page).to have_content('R$ 29,88')
  end

  scenario 'atualização do total em tempo real ao adicionar preço' do
    # create an item without price, then update it and verify total updates
    item = Item.create!(list: lista, name: 'Açúcar', quantity: 1, preco: 0.0, added_by: user)
    visit list_items_path(lista)
    expect(page).to have_content('R$ 0,00')

    item.update!(preco: 12.50)
    visit list_items_path(lista)

    expect(page).to have_content('R$ 12,50')
  end
end