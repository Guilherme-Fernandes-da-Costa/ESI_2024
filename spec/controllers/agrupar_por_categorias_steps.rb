require 'rails_helper'
begin
  require 'warden/test/helpers'
rescue LoadError
  # warden not available in this environment; we'll fallback below
end

RSpec.feature 'Agrupar itens por categoria', type: :feature do
  if defined?(Warden)
    include Warden::Test::Helpers
    Warden.test_mode!
  end
  let(:user) { User.create!(email: 'test@example.com', name: 'Teste') }

  background do
    # If Warden/Devise helpers are not available in this RSpec env,
    # stub current_user to simulate a logged-in user for feature specs.
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    @lista = List.create!(name: 'Compras da Semana', owner: user)
    visit list_path(@lista)
  end

  scenario 'aplicar tags aos itens da lista' do
    # Create items directly (no JS) and set tag on one of them
    Item.create!(list: @lista, name: 'Leite',  added_by: user, preco: 0.0, tag: 'Frios')
    Item.create!(list: @lista, name: 'Arroz',  added_by: user, preco: 0.0, tag: nil)

    visit list_path(@lista)

    within('li', text: 'Leite') do
      expect(page).to have_css('.tag-item', text: 'Frios')
    end

    within('li', text: 'Arroz') do
      expect(page).not_to have_css('.tag-item')
    end
  end

  scenario 'ordenar e filtrar itens pelo campo tag' do
    Item.create!(list: @lista, name: 'Queijo',      tag: 'Frios', added_by: user, preco: 0.0)
    Item.create!(list: @lista, name: 'Maçã',        tag: 'Horti-Fruti', added_by: user, preco: 0.0)
    Item.create!(list: @lista, name: 'Picanha',     tag: 'Carnes', added_by: user, preco: 0.0)
    Item.create!(list: @lista, name: 'Sabão em pó', tag: nil, added_by: user, preco: 0.0)

    # Base rendering: all items present
    visit list_path(@lista)
    expect(page).to have_content('Queijo (Frios)')
    expect(page).to have_content('Maçã (Horti-Fruti)')
    expect(page).to have_content('Picanha (Carnes)')

    # Filter by tag (server-side): only 'Queijo' should remain
    visit list_path(@lista, order: 'Frios')
    expect(page).to     have_content('Queijo')
    expect(page).not_to have_content('Maçã')
    expect(page).not_to have_content('Picanha')
    expect(page).not_to have_content('Sabão em pó')

    # Desagrupar (order param) should show everything again
    visit list_path(@lista, order: 'desagrupar')
    expect(page).to have_content('Queijo')
    expect(page).to have_content('Maçã')
    expect(page).to have_content('Picanha')

    # Agrupar should order items by tag (ascending)
    visit list_path(@lista, order: 'agrupar')
    items_html = find('ul').text
    carnes_idx = items_html.index('Carnes')
    frios_idx  = items_html.index('Frios')
    horti_idx  = items_html.index('Horti-Fruti')
    expect(carnes_idx).to be < frios_idx
    expect(frios_idx).to be < horti_idx
  end
end
