require 'rails_helper'

RSpec.feature 'Marcar itens como comprados', type: :feature do
  let(:user) { User.create!(email: 'mark_spec@example.com', name: 'Mark Spec') }
  let(:lista) { List.create!(name: 'Lista Marcar', owner: user) }

  background do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  scenario 'marcar um item como comprado atualiza a listagem' do
    item = Item.create!(list: lista, name: 'Leite', quantity: 1, preco: 3.50, added_by: user, comprado: false)

    visit list_items_path(lista)
    expect(page).to have_css("li#item_#{item.id}")
    expect(find("li#item_#{item.id}" )[:class]).not_to include('comprado')

    # Call the controller route that toggles comprado (rack-test submit via Capybara)
    page.driver.submit :patch, toggle_comprado_list_item_path(lista, item), {}

    visit list_items_path(lista)
    expect(find("li#item_#{item.id}" )[:class]).to include('comprado')
  end

  scenario 'desmarcar um item comprado reverte o estado' do
    item = Item.create!(list: lista, name: 'Pão', quantity: 2, preco: 2.00, added_by: user, comprado: true)

    visit list_items_path(lista)
    expect(find("li#item_#{item.id}" )[:class]).to include('comprado')

    page.driver.submit :patch, toggle_comprado_list_item_path(lista, item), {}

    visit list_items_path(lista)
    expect(find("li#item_#{item.id}" )[:class]).not_to include('comprado')
  end
end
