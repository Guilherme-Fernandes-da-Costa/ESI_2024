# app/models/item.rb
class Item < ApplicationRecord
  # Associações:
  belongs_to :list

  # Validações:
  validates :name, presence: true
  validates :preco, numericality: { greater_than_or_equal_to: 0 }

  # Adiciona itens sem tag ao final.
  scope :grouped_by_tag, -> { order(Arel.sql("CASE WHEN tag IS NULL THEN 1 ELSE 0 END, tag ASC")) }

  def marcar_como_comprado
    update(comprado: true) unless comprado?
  end

  def desmarcar_como_comprado
    update(comprado: false) if comprado?
  end
end
