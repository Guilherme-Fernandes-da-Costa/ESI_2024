# app/models/list.rb
class List < ApplicationRecord
  has_many :items
end
