class User < ApplicationRecord
    has_many :lists, foreign_key: :owner_id
    has_many :list_shares
    has_many :shared_lists, through: :list_shares, source: :list


    validates :email, presence: true
end