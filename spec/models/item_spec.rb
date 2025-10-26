# spec/models/item_spec.rb
require 'rails_helper'

RSpec.describe Item, type: :model do
  # Configuração inicial (Cria dependências para passar as validações)
  # ATENÇÃO: Se seu projeto usa FactoryBot, substitua List.create! e User.create! por suas factories
  # O Item real requer List e AddedBy, então precisamos criá-los.
  let(:list) { List.create!(name: "Minha Lista") } 
  let(:added_by) { User.create!(email: "user@example.com", password: "password123") }
  
  # Cria tags para testes
  let(:tag_comida) { Tag.create!(name: "Comida") }
  let(:tag_limpeza) { Tag.create!(name: "Limpeza") }

  # Atributos básicos para a criação de um Item válido
  let(:valid_item_attributes) do
    { 
      name: "Cenoura", 
      list: list, 
      added_by: added_by 
    }
  end

  # --- Validações e Associações (Necessário configurar Shoulda Matchers) ---
  
  describe 'Validações' do
    # O Item real tem 'validates :name, presence:true'
    it { should validate_presence_of(:name) }
    
    # As validações implícitas de belongs_to do Rails 5+
    it { should validate_presence_of(:list) }
    it { should validate_presence_of(:added_by) }
  end
  
  describe 'Associações' do
    # O modelo Item real usa associação Many-to-Many para Tags:

    # 5) Resolve o erro de associação has_many :taggings
    it { should have_many(:taggings) }
    
    # 6) Resolve o erro de associação has_many :tags, through: :taggings
    it { should have_many(:tags).through(:taggings) }

    # Mantém as associações obrigatórias
    it { should belong_to(:list) }
    it { should belong_to(:added_by).class_name('User') }
  end

  # --- Scopes e Métodos Personalizados ---

  # AJUSTE: O método real é `with_tag(tag_name)`
  describe '.with_tag' do
    # AJUSTE: Criação de Item deve usar 'tags: [tag_comida]' para o Many-to-Many
    let!(:item_banana) { Item.create!(valid_item_attributes.merge(name: "Banana", tags: [tag_comida])) }
    let!(:item_detergente) { Item.create!(valid_item_attributes.merge(name: "Detergente", tags: [tag_limpeza])) }
    let!(:item_sem_tag) { Item.create!(valid_item_attributes.merge(name: "Pão")) }

    it 'retorna apenas itens com a tag_name especificada' do
      # 7) AJUSTE: Usa o nome do método e o argumento correto (tag_name string)
      expect(Item.with_tag(tag_comida.name)).to include(item_banana)
      expect(Item.with_tag(tag_comida.name)).not_to include(item_detergente)
      expect(Item.with_tag(tag_comida.name)).not_to include(item_sem_tag)
      expect(Item.with_tag(tag_comida.name).count).to eq(1)
    end
  end
  
  # Teste para o escopo de ordenação
  describe '.sorted_by_tag' do
    # Cria tags com nomes que forçam uma ordenação alfabética
    let!(:tag_a) { Tag.create!(name: "A_Laticínios") }
    let!(:tag_z) { Tag.create!(name: "Z_Higiene") }
    
    # Item que deve vir primeiro (Tag A)
    let!(:item_a) { Item.create!(valid_item_attributes.merge(name: "Queijo", tags: [tag_a])) }
    
    # Item que deve vir depois (Tag Z)
    let!(:item_z) { Item.create!(valid_item_attributes.merge(name: "Sabonete", tags: [tag_z])) }
    
    # Item sem tag (o escopo do model do usuário não deve incluí-lo, pois usa `joins(:tag)`)
    let!(:item_none) { Item.create!(valid_item_attributes.merge(name: "Vazio")) }
    
    it 'ordena itens alfabeticamente pela tag e exclui itens sem tag' do
      # O escopo do usuário (joins(:tag)) exclui itens sem tag.
      ordered_items = Item.sorted_by_tag.to_a
      expect(ordered_items.first).to eq(item_a)
      expect(ordered_items.last).to eq(item_z)
      expect(ordered_items).not_to include(item_none)
    end
  end
end
