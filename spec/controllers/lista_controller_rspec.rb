require 'rails_helper'

RSpec.describe ListaController, type: :controller do
  let!(:lista) { Lista.create!(nome: "Minha Lista") }
  let!(:tag1) { Tag.create!(name: "Urgente") }
  let!(:tag2) { Tag.create!(name: "Opcional") }
  let!(:item1) { Item.create!(name: "Item 1", list: lista, tag_ids: [tag1.id]) }
  let!(:item2) { Item.create!(name: "Item 2", list: lista, tag_ids: [tag2.id]) }
  let!(:item3) { Item.create!(name: "Item 3", list: lista) }

  describe "GET #index" do
    it "retorna sucesso" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "atribui todos os itens à variável @itens" do
      get :index
      expect(assigns(:itens)).to match_array([item1, item2, item3])
    end

    it "filtra itens por tag" do
      get :index, params: { tag_id: tag1.id }
      expect(assigns(:itens)).to eq([item1])
    end

    it "ordena itens por tag" do
      get :index, params: { sort: "tag" }
      expect(assigns(:itens).first.tags.first.name).to eq("Opcional")
    end
  end
end
