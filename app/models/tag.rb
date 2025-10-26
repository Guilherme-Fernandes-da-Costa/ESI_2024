class Tag < ApplicationRecord
  has_many :taggings
  has_many :items, through: :taggings
  validates :name, presence: true, uniqueness: true

  # Lógica para obter tags pré-cadastradas
  def self.pre_registered
    all
  end
end
