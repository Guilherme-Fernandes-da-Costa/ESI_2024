# app/models/user.rb
class User < ApplicationRecord
  has_secure_password

  has_many :owned_lists, class_name: 'List', foreign_key: 'owner_id', dependent: :destroy
  has_many :items, foreign_key: 'added_by_id', dependent: :destroy
  has_many :list_shares, dependent: :destroy
  has_many :shared_lists, through: :list_shares, source: :list

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true
end