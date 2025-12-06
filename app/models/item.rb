# app/models/item.rb
class Item < ApplicationRecord
  # Associações:
  belongs_to :list
  belongs_to :added_by, class_name: "User", optional: true
  # `tag` is stored as a simple string column on items in this app
  # (there is also a Tag model, but items use a `tag` string for simple categorization)

  # Atributos:
  # - name: string
  # - quantity: integer
  # - preco: decimal
  # - comprado: boolean
  # - tag: string
  # Validações:
  validates :name, presence: true
  validates :preco, numericality: { greater_than_or_equal_to: 0 }

  # Agrupa/ordena por coluna de tag (string) quando não há associação Tag
  # Place items with nil tag at the end when grouping/ordering
  scope :grouped_by_tag, -> { order(Arel.sql("CASE WHEN tag IS NULL THEN 1 ELSE 0 END, tag ASC")) }

  def marcar_como_comprado
    update(comprado: true) unless comprado?
  end

  def desmarcar_como_comprado
    update(comprado: false) if comprado?
  end
end
