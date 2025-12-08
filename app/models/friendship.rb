# app/models/friendship.rb
class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates :user_id, uniqueness: { scope: :friend_id, message: "Esta amizade já existe" }
  validate :cannot_add_self_as_friend

  private

  def cannot_add_self_as_friend
    errors.add(:friend, "Não é possível adicionar a si mesmo como amigo") if user_id == friend_id
  end
end
