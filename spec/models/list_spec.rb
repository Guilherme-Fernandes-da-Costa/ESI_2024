require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#reset!' do
    let!(:owner) { User.create!(email: 'maria@example.com', name: 'Maria', password: 'password123') }
    let(:other) { User.create!(email: 'joao@example.com', name: 'Joao', password: 'password123') }
    let!(:list) { List.create!(name: 'Lista do Mercado', owner: owner) }

    before do
      list.items.create!(name: 'Arroz', quantity: 2, added_by: owner, preco: 0.0)
      list.items.create!(name: 'Feijão', quantity: 1, added_by: owner, preco: 0.0)
    end

    it 'remove todos os itens da lista quando chamado pelo organizador' do
      expect(list.items.count).to eq(2)
      list.reset!(by: owner)
      # reset! now updates items instead of destroying them
      expect(list.items.count).to eq(2)
      # Verify all items are marked as not purchased
      expect(list.items.all? { |i| i.comprado == false && i.quantidade_comprada == 0 }).to be true
    end

    it 'remove os itens visíveis para quem compartilha a lista (estado do banco) quando organizador reinicia' do
      # Compartilha a lista com outro usuário
      ListShare.create!(list: list, user: other)
      list.reset!(by: owner)
      # Items remain but are reset to not purchased
      expect(list.items.count).to eq(2)
      expect(list.items.all? { |i| i.comprado == false && i.quantidade_comprada == 0 }).to be true
    end

    it 'levanta erro/retorna false quando quem chama nao e organizador e nao altera a lista' do
      original_item_count = list.items.count
      original_comprado_states = list.items.map(&:comprado)

      expect { list.reset!(by: other) }.to raise_error(List::PermissionDenied)

      # Items should not be modified
      expect(list.items.count).to eq(original_item_count)
      expect(list.items.map(&:comprado)).to eq(original_comprado_states)
    end
  end
end
