# app/models/item.rb
class Item < ApplicationRecord
  # Associações:
  belongs_to :list
  belongs_to :added_by, class_name: 'User', optional: true
  belongs_to :tag, optional: true

  # Validações:
  validates :name, presence: true
  validates :preco, numericality: { greater_than_or_equal_to: 0 }

  # Agrupa/ordena por coluna de tag (string) quando não há associação Tag
  scope :grouped_by_tag, -> { order(tag: :asc) }

  def marcar_como_comprado
    update(comprado: true) unless comprado?
  end

  def desmarcar_como_comprado
    update(comprado: false) if comprado?
  end
end
