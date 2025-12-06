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
end