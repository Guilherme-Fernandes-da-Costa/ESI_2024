FactoryBot.define do
  factory :list do
    sequence(:name) { |n| "Lista #{n}" }
    association :owner, factory: :user
  end

  factory :shopping_list, parent: :list do
    name { "Minha Lista" }
  end
end
# (only one list factory defined above)
