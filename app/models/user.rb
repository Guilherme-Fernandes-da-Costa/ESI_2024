# app/models/user.rb
class User < ApplicationRecord
  has_secure_password

  has_many :owned_lists, class_name: 'List', foreign_key: 'owner_id', dependent: :destroy
  has_many :items, foreign_key: 'added_by_id', dependent: :destroy
  has_many :list_shares, dependent: :destroy
  has_many :shared_lists, through: :list_shares, source: :list

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, source: :friend
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true
end
