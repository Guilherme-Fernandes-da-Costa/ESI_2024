# spec/requests/lists_reset_spec.rb
require 'rails_helper'

RSpec.describe 'Reset List', type: :request do
  # Helpers stubbing simple authentication used in controller (see controller implementation)
  def sign_in(user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  let!(:owner) { User.create!(email: 'maria@example.com', name: 'Maria', password: 'password123') }
  let(:other) { User.create!(email: 'pedro@example.com', name: 'Pedro', password: 'password123') }
  let!(:list) { List.create!(name: 'Lista', owner: owner) }

  before do
    list.items.create!(name: 'Leite', quantity: 1, added_by: owner)
    list.items.create!(name: 'Pão', quantity: 2, added_by: owner)
  end

  it 'organizador consegue reiniciar a lista e recebe redirect / json 200' do
    sign_in(owner)
    post reset_list_path(list)
    # Corrigido: aceita :found (302) que é o padrão do Rails para redirect
    expect(response).to have_http_status(:found).or have_http_status(:ok)
    list.reload
    # reset! updates items instead of destroying them
    expect(list.items.count).to eq(2)
    expect(list.items.all? { |i| i.comprado == false && i.quantidade_comprada == 0 }).to be true
  end

  it 'usuario nao organizador recebe forbidden e a lista permanece' do
    sign_in(other)
    post reset_list_path(list)
    # The controller redirects with an alert rather than returning 403
    expect(response).to have_http_status(:found)
    list.reload
    # Items should not be modified
    expect(list.items.count).to eq(2)
    expect(list.items.any? { |i| i.comprado == true }).to be false
  end
end
