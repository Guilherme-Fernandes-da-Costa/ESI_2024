class User < ApplicationRecord
  has_many :items, foreign_key: :added_by_id
end
