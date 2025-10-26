class Lista < ApplicationRecord
  self.table_name = "listas"
  has_many :items
end
