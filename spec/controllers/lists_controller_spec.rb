require 'rails_helper'

RSpec.describe ListsController, type: :controller do
  # Testes existentes (não alterar, apenas adicionar)
  # Assumindo autenticação mockada

  before do
    sign_in create(:user) # Use Devise ou similar para autenticação
  end

  describe 'POST #create' do
    context 'com parâmetros válidos para tipo mercado' do
      it 'cria uma lista com tipo mercado' do
        post :create, params: { list: { name: 'Compras Semanais', kind: 'mercado' } }
        expect(response).to redirect_to(list_path(assigns(:list)))
        expect(assigns(:list).kind).to eq('mercado')
        expect(flash[:notice]).to eq('Lista criada com sucesso.')
      end
    end

    context 'com parâmetros válidos para tipo viagem' do
      it 'cria uma lista com tipo viagem' do
        post :create, params: { list: { name: 'Viagem para Praia', kind: 'viagem' } }
        expect(response).to redirect_to(list_path(assigns(:list)))
        expect(assigns(:list).kind).to eq('viagem')
        expect(flash[:notice]).to eq('Lista criada com sucesso.')
      end
    end

    context 'com parâmetros inválidos (sem tipo)' do
      it 'não cria a lista e renderiza new' do
        post :create, params: { list: { name: 'Lista Sem Tipo', kind: nil } }
        expect(response).to render_template(:new)
        expect(flash[:alert]).to include('Tipo é obrigatório')
      end
    end
  end
end