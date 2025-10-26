class Lista < ApplicationRecord
  self.table_name = "lists"
  has_many :items
end
