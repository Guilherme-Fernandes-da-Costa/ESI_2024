# app/models/item.rb
class Item < ApplicationRecord
  belongs_to :list
  belongs_to :added_by, class_name: "User", optional: true

  validates :name, presence: true
  validates :preco, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :quantidade_comprada, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: :quantity,
    message: "não pode ser maior que a quantidade total"
  }, allow_nil: true

  scope :grouped_by_tag, -> { order(Arel.sql("tag ASC NULLS LAST")) }

  # Verifica se está totalmente comprado
  def totalmente_comprado?
    quantidade_comprada.to_i >= quantity
  end

  # Calcula quanto falta comprar
  def falta_comprar
    quantity - (quantidade_comprada || 0)
  end

  # Calcula o subtotal (quantidade * preço)
  def subtotal
    quantity * preco
  end
end
