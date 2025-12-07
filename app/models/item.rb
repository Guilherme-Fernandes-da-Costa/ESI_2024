# app/models/item.rb
class Item < ApplicationRecord
  # Associações:
  belongs_to :list
  belongs_to :added_by, class_name: 'User'


  # Validações:
  validates :name, presence: true
  validates :preco, numericality: { greater_than_or_equal_to: 0 }

  # Adiciona itens sem tag ao final.
  scope :grouped_by_tag, -> { order("tag ASC NULLS LAST") }

  def marcar_como_comprado
    update(comprado: true) unless comprado?
  end

  def desmarcar_como_comprado
    update(comprado: false) if comprado?
  end
end
