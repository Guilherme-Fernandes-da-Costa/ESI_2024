require 'rails_helper'

RSpec.describe 'Agrupar itens por categoria', type: :request do
  let(:user) { User.create!(email: 'test@example.com', name: 'Teste', password: 'password123') }
  let(:lista) { List.create!(name: 'Compras da Semana', owner: user) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  it 'aplica e exibe tags nos itens' do
    Item.create!(list: lista, name: 'Leite',  added_by: user, preco: 0.0, tag: 'Frios')
    Item.create!(list: lista, name: 'Arroz',  added_by: user, preco: 0.0, tag: nil)

    get list_path(lista)

    expect(response).to have_http_status(:success)
    expect(response.body).to include('Leite')
    expect(response.body).to include('Frios')
  end

  it 'filtra itens pelo campo tag' do
    Item.create!(list: lista, name: 'Queijo',      tag: 'Frios', added_by: user, preco: 0.0)
    Item.create!(list: lista, name: 'Maçã',        tag: 'Horti-Fruti', added_by: user, preco: 0.0)
    Item.create!(list: lista, name: 'Picanha',     tag: 'Carnes', added_by: user, preco: 0.0)
    Item.create!(list: lista, name: 'Sabão em pó', tag: nil, added_by: user, preco: 0.0)

    get list_path(lista, order: 'Frios')

    expect(response).to have_http_status(:success)
    expect(response.body).to include('Queijo')
    expect(response.body).not_to include('Maçã')
    expect(response.body).not_to include('Picanha')
  end

  it 'desagrupa e exibe todos os itens' do
    Item.create!(list: lista, name: 'Queijo',      tag: 'Frios', added_by: user, preco: 0.0)
    Item.create!(list: lista, name: 'Maçã',        tag: 'Horti-Fruti', added_by: user, preco: 0.0)

    get list_path(lista, order: 'desagrupar')

    expect(response).to have_http_status(:success)
    expect(response.body).to include('Queijo')
    expect(response.body).to include('Maçã')
  end

  it 'agrupa itens por tag em ordem alfabética' do
    Item.create!(list: lista, name: 'Queijo',      tag: 'Frios', added_by: user, preco: 0.0)
    Item.create!(list: lista, name: 'Maçã',        tag: 'Horti-Fruti', added_by: user, preco: 0.0)
    Item.create!(list: lista, name: 'Picanha',     tag: 'Carnes', added_by: user, preco: 0.0)

    get list_path(lista, order: 'agrupar')

    expect(response).to have_http_status(:success)
    # Verify items are ordered by tag (Carnes < Frios < Horti-Fruti alphabetically)
    items = Item.grouped_by_tag.map { |i| "#{i.name}:#{i.tag}" }
    expect(items).to eq([ 'Picanha:Carnes', 'Queijo:Frios', 'Maçã:Horti-Fruti' ])
  end
end
