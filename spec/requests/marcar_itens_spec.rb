require 'rails_helper'

RSpec.describe 'Marcar itens como comprados', type: :request do
  let(:user) { User.create!(email: 'mark_spec@example.com', name: 'Mark Spec') }
  let(:lista) { List.create!(name: 'Lista Marcar', owner: user) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  it 'marca um item como comprado' do
    item = Item.create!(list: lista, name: 'Leite', quantity: 1, preco: 3.50, added_by: user, comprado: false)

    patch toggle_comprado_list_item_path(lista, item)

    item.reload
    expect(item.comprado).to be true
  end

  it 'desmarca um item comprado' do
    item = Item.create!(list: lista, name: 'Pão', quantity: 2, preco: 2.00, added_by: user, comprado: true)

    patch toggle_comprado_list_item_path(lista, item)

    item.reload
    expect(item.comprado).to be false
  end
end
