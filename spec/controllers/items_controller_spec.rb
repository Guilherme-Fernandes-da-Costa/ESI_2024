require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  describe "POST #create" do
    context "com parâmetros válidos" do
      let(:valid_attributes) { { item: { name: "Pão Integral" } } }

      it "cria um novo Item" do
        expect {
          post :create, params: valid_attributes
        }.to change(Item, :count).by(1)
      end

      it "redireciona para a página da lista" do
        post :create, params: valid_attributes
        expect(response).to redirect_to(lista_path)
      end
    end

    context "com tags selecionadas" do
      let!(:tag) { Tag.create!(name: "Comida") }
      let(:valid_attributes_with_tag) { { item: { name: "Cerveja", tag_ids: [tag.id] } } }

      it "cria o Item com a tag associada" do
        post :create, params: valid_attributes_with_tag
        expect(Item.last.tags).to include(tag)
      end
    end
  end
end
