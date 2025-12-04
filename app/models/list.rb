class List < ApplicationRecord
  class PermissionDenied < StandardError; end

  # Associações:
  belongs_to :owner, class_name: "User", optional: true
  has_many :items, dependent: :destroy
  has_many :list_shares, dependent: :destroy
  has_many :shared_users, through: :list_shares, source: :user

  # Validações (mínimas):
  validates :name, presence: true

  # Compatibilidade com specs/fixtures em português
  def nome
    name
  end

  def nome=(value)
    self.name = value
  end

  # Reinicia a lista: apenas o owner (organizador) pode executar
  # by: User que está solicitando a ação
  def reset!(by:)
    raise PermissionDenied unless by == owner

    # Transação para garantir consistência
    transaction do
      items.destroy_all
    end

    true
  end
end
