FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "Item #{n}" }
    quantity { 1 }
    preco { 0.0 }
    comprado { false }
    quantidade_comprada { 0 }
    association :list
    association :added_by, factory: :user
  end

  factory :list_item, parent: :item do
    name { "List Item" }
  end
end
