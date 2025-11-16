# spec/requests/lists_create_spec.rb
require 'rails_helper'

RSpec.describe 'Create List', type: :request do
  def sign_in(user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  let(:user) { User.create!(email: 'user@example.com', name: 'Test User') }

  describe 'POST /lists' do
    context 'with valid parameters' do
      it 'creates a new list and redirects to the list page' do
        sign_in(user)

        expect {
          post lists_path, params: { list: { name: 'Lista de Compras da Semana' } }
        }.to change(List, :count).by(1)

        expect(response).to have_http_status(:found) # redirect
        expect(flash[:notice]).to eq('Lista criada com sucesso!')

        new_list = List.last
        expect(new_list.name).to eq('Lista de Compras da Semana')
        expect(new_list.owner).to eq(user)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a list and returns unprocessable entity' do
        sign_in(user)

        expect {
          post lists_path, params: { list: { name: '' } }
        }.not_to change(List, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when user is not logged in' do
      it 'does not create a list' do
        # current_user returns nil by default in ApplicationController

        expect {
          post lists_path, params: { list: { name: 'Lista Teste' } }
        }.not_to change(List, :count)

        expect(response).to have_http_status(:unauthorized) # or whatever status you choose
      end
    end
  end

  describe 'GET /lists/new' do
    it 'returns the new list form' do
      sign_in(user)
      get new_list_path
      expect(response).to have_http_status(:ok)
    end
  end
end