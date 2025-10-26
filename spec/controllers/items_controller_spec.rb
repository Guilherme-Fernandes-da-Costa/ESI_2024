require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let!(:lista) { Lista.create!(nome: "Minha Lista") }
  let!(:tag1) { Tag.create!(name: "Urgente") }
  let!(:tag2) { Tag.create!(name: "Opcional") }

  let(:valid_attributes) { { name: "Novo Item", tag_ids: [tag1.id] } }
  let(:invalid_attributes) { { name: "" } }

  describe "GET #new" do
    it "retorna sucesso" do
      get :new, params: { lista_id: lista.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "com atributos válidos" do
      it "cria um novo item" do
        expect {
          post :create, params: { lista_id: lista.id, item: valid_attributes }
        }.to change(Item, :count).by(1)
      end

      it "redireciona para a lista" do
        post :create, params: { lista_id: lista.id, item: valid_attributes }
        expect(response).to redirect_to(lista_path)
      end
    end

    context "com atributos inválidos" do
      it "não cria item" do
        expect {
          post :create, params: { lista_id: lista.id, item: invalid_attributes }
        }.not_to change(Item, :count)
      end

      it "renderiza new novamente" do
        post :create, params: { lista_id: lista.id, item: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    let!(:item) { Item.create!(name: "Item Antigo", list: lista) }

    context "com atributos válidos" do
      it "atualiza o item" do
        patch :update, params: { lista_id: lista.id, id: item.id, item: { name: "Item Atualizado" } }
        expect(item.reload.name).to eq("Item Atualizado")
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:item) { Item.create!(name: "Item a remover", list: lista) }

    it "remove o item" do
      expect {
        delete :destroy, params: { lista_id: lista.id, id: item.id }
      }.to change(Item, :count).by(-1)
    end
  end
end
