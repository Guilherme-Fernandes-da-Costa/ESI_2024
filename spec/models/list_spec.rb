require 'rails_helper'

RSpec.describe List, type: :model do
  # Testes existentes (não alterar, apenas adicionar)

  describe 'validações para diferentes tipos' do
    it 'permite criar lista com tipo mercado' do
      list = build(:list, name: 'Compras Semanais', kind: 'mercado') # Use FactoryBot
      expect(list).to be_valid
      expect(list.save).to be true
    end

    it 'permite criar lista com tipo viagem' do
      list = build(:list, name: 'Viagem para Praia', kind: 'viagem')
      expect(list).to be_valid
      expect(list.save).to be true
    end

    it 'rejeita lista sem tipo' do
      list = build(:list, name: 'Lista Sem Tipo', kind: nil)
      expect(list).not_to be_valid
      expect(list.errors[:kind]).to include("can't be blank") # Assumindo presence: true no modelo
    end

    it 'valida tipos permitidos (enum)' do
      # Assumindo enum no modelo: enum kind: { mercado: 'mercado', viagem: 'viagem', ... }
      list = build(:list, kind: 'invalido')
      expect(list).not_to be_valid
      expect(list.errors[:kind]).to include('is not included in the list')
    end
  end

  describe '#reset!' do
    let!(:owner) { User.create!(email: 'maria@example.com', name: 'Maria') }
    let(:other) { User.create!(email: 'joao@example.com', name: 'Joao') }
    let!(:list) { List.create!(name: 'Lista do Mercado', owner: owner) }

    before do
      list.items.create!(name: 'Arroz', quantity: 2, added_by: owner)
      list.items.create!(name: 'Feijão', quantity: 1, added_by: owner)
    end

    it 'remove todos os itens da lista quando chamado pelo organizador' do
      expect(list.items.count).to eq(2)
      list.reset!(by: owner)
      expect(list.items.count).to eq(0)
    end

    it 'remove os itens visíveis para quem compartilha a lista (estado do banco) quando organizador reinicia' do
      # Compartilha a lista com outro usuário
      ListShare.create!(list: list, user: other)
      list.reset!(by: owner)
      # items são modelos associados à lista — se foram removidos, estarão ausentes para todos os usuários
      expect(list.items.count).to eq(0)
    end

    it 'levanta erro/retorna false quando quem chama nao e organizador e nao altera a lista' do
      original_items = list.items.to_a
      expect { list.reset!(by: other) }.to raise_error(List::PermissionDenied)
      expect(list.items.map(&:attributes)).to eq(original_items.map(&:attributes))
    end
  end
end
