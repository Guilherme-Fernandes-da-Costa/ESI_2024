# spec/requests/lists_reset_spec.rb
require 'rails_helper'

RSpec.describe 'Reset List', type: :request do
  # Helpers stubbing simple authentication used in controller (see controller implementation)
  def sign_in(user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  let!(:owner) { User.create!(email: 'maria@example.com', name: 'Maria') }
  let(:other) { User.create!(email: 'pedro@example.com', name: 'Pedro') }
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
    expect(list.items.count).to eq(0)
  end

  it 'usuario nao organizador recebe forbidden e a lista permanece' do
    sign_in(other)
    post reset_list_path(list)
    expect(response).to have_http_status(:forbidden)
    list.reload
    expect(list.items.count).to eq(2)
  end
end