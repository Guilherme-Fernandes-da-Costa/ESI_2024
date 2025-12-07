require 'rails_helper'

RSpec.describe 'Exibir preços dos itens', type: :request do
  let(:user)  { User.create!(email: 'test@spec.local', name: 'Spec User') }
  let(:lista) { List.create!(name: 'Compras do Mês', owner: user) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  it 'exibe preço ao adicionar item' do
    Item.create!(list: lista, name: 'Arroz 5kg', quantity: 3, preco: 24.90, added_by: user)

    get list_items_path(lista)

    expect(response).to have_http_status(:success)
    expect(response.body).to include('Arroz 5kg')
    expect(response.body).to include('24,90')
  end

  it 'exibe soma total correta da lista' do
    Item.create!(list: lista, name: 'Leite Integral',  preco: 4.99,  added_by: user)
    Item.create!(list: lista, name: 'Pão de Forma',    preco: 8.99,  added_by: user)
    Item.create!(list: lista, name: 'Sabão em Pó 1kg', preco: 15.90, quantity: 2, added_by: user)

    get list_items_path(lista)

    expect(response).to have_http_status(:success)
    expect(response.body).to include('R$ 29,88')
  end

  it 'atualiza total quando item é adicionado' do
    item = Item.create!(list: lista, name: 'Açúcar', quantity: 1, preco: 0.0, added_by: user)

    get list_items_path(lista)
    expect(response.body).to include('R$ 0,00')

    item.update!(preco: 12.50)

    get list_items_path(lista)
    expect(response.body).to include('R$ 12,50')
  end
end
