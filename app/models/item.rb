# app/models/item.rb
class Item < ApplicationRecord
  # Associações:
  belongs_to :list

  # Validações:
  validates :name, presence: true

  # Adiciona itens sem tag ao final.
  scope :grouped_by_tag, -> { order(Arel.sql("CASE WHEN tag IS NULL THEN 1 ELSE 0 END, tag ASC")) }
end
