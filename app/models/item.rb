# app/models/item.rb
class Item < ApplicationRecord
  belongs_to :list
  belongs_to :added_by, class_name: 'User'
  
  has_many :taggings
  has_many :tags, through: :taggings
  validates :name, presence:true

  def self.with_tag(tag_name)
    joins(:tags).where(tags: { name: tag_name })
  end

  # Escopo para ordenar itens pela tag (necessário para a função 'Agrupar')
  # Assumes que itens sem tag devem ser excluídos na ordenação por tag
  scope :sorted_by_tag, -> { joins(:tag).order('tags.name ASC') }
  
  # Escopo para filtrar itens por tag (necessário para a função 'Filtrar')
  scope :filter_by_tag, ->(tag_id) { where(tag_id: tag_id) }
end
