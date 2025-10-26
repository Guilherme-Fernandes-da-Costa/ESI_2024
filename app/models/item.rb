# app/models/item.rb
class Item < ApplicationRecord
  # belongs_to :list
  # belongs_to :added_by, class_name: 'User'
  
  has_many :taggings
  has_many :tags, through: :taggings
  validates :name, presence:true

  def self.with_tag(tag_name)
    joins(:tags).where(tags: { name: tag_name })
  end
end
