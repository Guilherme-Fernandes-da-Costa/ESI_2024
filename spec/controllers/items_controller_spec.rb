require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  # Configuração das dependências necessárias para o Item
  # Assumimos que o modelo User e List precisam apenas de email e nome, respectivamente.
  # Se o seu User precisar de outros atributos (e.g., username), ajuste aqui.
  let!(:user) { User.create!(email: "teste@exemplo.com") }
  let!(:list) { List.create!(name: "Lista de Compras", user: user) }
  let!(:tag) { Tag.create!(name: "Frios") }

  let(:valid_attributes) do
    { item: { name: "Manteiga", list_id: list.id, added_by_id: user.id } }
  end

  let(:valid_attributes_with_tag) do
    { item: { name: "Leite", list_id: list.id, added_by_id: user.id, tag_ids: [tag.id] } }
  end

  let(:invalid_attributes) do
    # Parâmetros inválidos (sem nome)
    { item: { name: "", list_id: list.id, added_by_id: user.id } }
  end

  describe "POST #create" do
    context "com parâmetros válidos" do
      it "cria um novo Item" do
        expect {
          post :create, params: valid_attributes
        }.to change(Item, :count).by(1)
      end

      it "redireciona para a página da lista" do
        post :create, params: valid_attributes
        # Rota corrigida para items_path (que aponta para a action index)
        expect(response).to redirect_to(items_path)
      end
    end

    context "com tags selecionadas" do
      it "cria o Item com a tag associada" do
        post :create, params: valid_attributes_with_tag
        created_item = Item.last
        # Asserção corrigida para a relação has_many
        expect(created_item.tags).to include(tag)
      end
    end

    context "com parâmetros inválidos" do
      it "não cria o Item" do
        expect {
          post :create, params: invalid_attributes
        }.not_to change(Item, :count)
      end

      it "renderiza :index" do
        post :create, params: invalid_attributes
        # Status code corrigido para a nova recomendação do Rails
        expect(response).to render_template(:index)
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  # Testes adicionais para a nova action 'sort' (opcional, mas recomendado)
  describe "GET #sort" do
    let!(:item_frios) { Item.create!(name: "Queijo", list: list, added_by: user, tags: [tag]) }
    let!(:item_sem_tag) { Item.create!(name: "Pão", list: list, added_by: user) }

    it "filtra itens pela tag" do
      get :sort, params: { tag: tag.name }
      expect(assigns(:items)).to eq([item_frios])
      expect(assigns(:items)).not_to include(item_sem_tag)
    end
  end
end
