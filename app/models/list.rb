class List < ApplicationRecord
  class PermissionDenied < StandardError; end

  # Associações:
  belongs_to :owner, class_name: "User", optional: true
  has_many :items, dependent: :destroy
  has_many :list_shares, dependent: :destroy
  has_many :shared_users, through: :list_shares, source: :user

  # Validações (mínimas):
  validates :name, presence: true
  accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true

  # Compatibilidade com specs/fixtures em português
  def nome
    name
  end

  def nome=(value)
    self.name = value
  end

  # Reinicia a lista: apenas o owner (organizador) pode executar
  def reset!(by:)
    raise PermissionDenied unless by == owner

    # Transação para garantir consistência
    transaction do
      # Primeiro, vamos verificar se há itens
      Rails.logger.info "Resetando lista #{id}: #{items.count} itens encontrados"

      # Em vez de destroy_all, vamos fazer update para manter os itens mas zerar as quantidades
      items.each do |item|
        item.update!(
          comprado: false,
          quantidade_comprada: 0
        )
        Rails.logger.info "Item #{item.id} resetado"
      end

      # Se preferir realmente apagar os itens, use:
      # items.destroy_all
    end

    true
  end
end
