# app/models/list.rb
class List < ApplicationRecord
  # Associações:
  has_many :items, dependent: :destroy

  # Validações (mínimas):
  validates :name, presence: true
end
