# spec/models/item_spec.rb
require 'rails_helper'

RSpec.describe Item, type: :model do
  # Cria um objeto List para ser associado aos Items
  let(:list) { create(:list, name: "Minha Lista de Teste") }

  it "é válido com nome e lista" do
    item = Item.new(name: "Pão", list: list)
    expect(item).to be_valid
  end

  it "não é válido sem nome" do
    item = Item.new(name: nil, list: list)
    expect(item).to_not be_valid
  end

  it "não é válido sem lista" do
    item = Item.new(name: "Cerveja", list: nil)
    expect(item).to_not be_valid
  end

  # Teste para o campo tag - Cenário 1
  it "é válido com uma tag atribuída" do
    item = Item.new(name: "Leite", tag: "frios", list: list)
    expect(item).to be_valid
    expect(item.tag).to eq("frios")
  end

  it "é válido com tag nula (opcional)" do
    item = Item.new(name: "Arroz", tag: nil, list: list)
    expect(item).to be_valid
    expect(item.tag).to be_nil
  end

  # Teste para o agrupamento (Escopo) - Cenário 2 (futuro)
  # Este teste usa FactoryBot. Certifique-se de que FactoryBot esteja configurado.
  describe ".grouped_by_tag" do
    before do
      create(:item, name: "Maçã", tag: "horti-fruit", list: list)
      create(:item, name: "Carne", tag: "carne", list: list)
      create(:item, name: "Pão", tag: "padaria", list: list)
      create(:item, name: "Cerveja", tag: nil, list: list)
    end

    # Teste para ordenar
    it "ordena os itens pelo nome da tag" do
      grouped_items = Item.grouped_by_tag
      # Os itens agrupados devem vir na ordem alfabética das tags:
      # carne, horti-fruit, padaria, nil (ou 'sem tag')
      expect(grouped_items.map(&:tag)).to eq([ "carne", "horti-fruit", "padaria", nil ])
    end
  end
end
