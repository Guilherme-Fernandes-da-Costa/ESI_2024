# app/models/list.rb
class List < ApplicationRecord
    class PermissionDenied < StandardError; end


    belongs_to :owner, class_name: 'User'
    has_many :items, dependent: :destroy
    has_many :list_shares, dependent: :destroy
    has_many :shared_users, through: :list_shares, source: :user


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