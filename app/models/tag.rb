class Tag < ApplicationRecord
  has_many :items, dependent: :nullify
  validates :name, presence: true, uniqueness: true

  # Lógica para obter tags pré-cadastradas
  def self.pre_registered
    all
  end
end
