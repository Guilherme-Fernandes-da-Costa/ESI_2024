# spec/controllers/items_controller_spec.rb
require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  # Configuração inicial (FactoryBot ou instâncias para dependências)
  # ATENÇÃO: Substitua pelos métodos de criação de suas factories, se aplicável
  let!(:list) { List.create!(name: "Lista de Compras") }
  let!(:user) { User.create!(email: "teste@exemplo.com") }
  let!(:tag) { Tag.create!(name: "Laticínios") }
  
  # Simula um usuário logado (necessário se o controller usa before_action para autenticação)
  # Se o seu controller não usa Devise/Autenticação, você pode remover o método abaixo
  before do
    # Isto assume que você tem alguma forma de logar um usuário, por exemplo, Devise ou Session
    # Se você usa Devise, use `sign_in user`
    # Se não, adicione o user_id (ou added_by_id) na sessão ou nos atributos
  end

  # Atributos válidos incluem as dependências obrigatórias
  let(:valid_attributes) { { item: { name: "Leite", list_id: list.id, added_by_id: user.id } } }
  let(:invalid_attributes) { { item: { name: "", list_id: list.id, added_by_id: user.id } } }
  
  # CORREÇÃO CRÍTICA (1): Alterado de `tag_id` para `tag_ids: []` para suportar has_many :tags
  let(:valid_attributes_with_tag) { { item: { name: "Iogurte", list_id: list.id, added_by_id: user.id, tag_ids: [tag.id] } } }


  describe "POST #create" do
    context "com parâmetros válidos" do
      
      # 1) Resolve o erro de dependência adicionando list_id e added_by_id nos atributos válidos
      it "cria um novo Item" do
        expect {
          post :create, params: valid_attributes
        }.to change(Item, :count).by(1)
      end

      # 2) Resolve o NameError trocando lista_path por items_path
      it "redireciona para a página da lista" do
        post :create, params: valid_attributes
        expect(response).to redirect_to(items_path)
      end
    end

    context "com tags selecionadas" do
      # 3) Resolve o NoMethodError: undefined method `tags'
      # CORREÇÃO CRÍTICA (2): Asserção alterada para usar `created_item.tags` (has_many) em vez de `created_item.tag` (belongs_to)
      it "cria o Item com a tag associada" do
        post :create, params: valid_attributes_with_tag
        created_item = Item.last
        
        # Como o modelo usa `has_many :tags`, verificamos se a coleção inclui a tag
        expect(created_item.tags).to include(tag) 
      end
    end
    
    context "com parâmetros inválidos" do
      # Teste para garantir que a validação do nome funcione
      it "não cria o Item e renderiza :index" do
        expect {
          post :create, params: invalid_attributes
        }.to_not change(Item, :count)
        
        # Atualizado de :unprocessable_entity para :unprocessable_content (Rails 7.1)
        expect(response).to render_template(:index)
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end
end
