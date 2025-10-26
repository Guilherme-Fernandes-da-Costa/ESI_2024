class AddPrecoToItem < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :preco, :decimal
  end
end
