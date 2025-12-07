class List < ApplicationRecord
  class PermissionDenied < StandardError; end

  # Associações:
  belongs_to :owner, class_name: 'User'
  has_many :items, dependent: :destroy
  has_many :list_shares, dependent: :destroy
  has_many :shared_users, through: :list_shares, source: :user

  # Validações (mínimas):
  validates :name, presence: true
  accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true
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
