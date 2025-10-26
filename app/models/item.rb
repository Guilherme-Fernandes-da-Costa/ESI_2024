# app/models/item.rb
class Item < ApplicationRecord
  # Associações:
  belongs_to :list

  # Validações:
  validates :name, presence: true
end
