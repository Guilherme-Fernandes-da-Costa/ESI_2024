class List < ApplicationRecord
  self.table_name = "lists"
  has_many :items
end
