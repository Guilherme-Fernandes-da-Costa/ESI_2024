# app/models/item.rb
class Item < ApplicationRecord
  belongs_to :list
  belongs_to :added_by, class_name: 'User'
end
