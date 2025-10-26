require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_many(:taggings) }
  it { should have_many(:tags).through(:taggings) }

  describe ".with_tag" do
    let!(:tag_comida) { Tag.create!(name: "Comida") }
    let!(:tag_casa) { Tag.create!(name: "Casa") }
    let!(:item_banana) { Item.create!(name: "Banana", tags: [tag_comida]) }
    let!(:item_leite) { Item.create!(name: "Leite", tags: [tag_comida]) }
    let!(:item_detergente) { Item.create!(name: "Detergente", tags: [tag_casa]) }

    it "retorna apenas itens com a tag especificada" do
      expect(Item.with_tag("Comida")).to include(item_banana, item_leite)
      expect(Item.with_tag("Comida")).not_to include(item_detergente)
    end
  end
end
