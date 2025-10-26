# spec/models/item_spec.rb
RSpec.describe Item, type: :model do
  let(:tag1) { Tag.create!(name: "Compras") }
  let(:tag2) { Tag.create!(name: "Estudos") }
  let(:user) { User.create!(name: "Teste") }
  let(:list) { List.create!(name: "Principal") }

  it "é válido com nome, lista e usuário" do
    item = Item.new(name: "Bananas", list: list, added_by: user)
    expect(item).to be_valid
  end

  it "pode ter múltiplas tags" do
    item = Item.create!(name: "Bananas", list: list, added_by: user, tags: [tag1, tag2])
    expect(item.tags.count).to eq(2)
  end

  it "filtra por tag corretamente" do
    item1 = Item.create!(name: "Bananas", list: list, added_by: user, tags: [tag1])
    item2 = Item.create!(name: "Livro", list: list, added_by: user, tags: [tag2])
    expect(Item.with_tag("Compras")).to include(item1)
    expect(Item.with_tag("Compras")).not_to include(item2)
  end
end
