class AddQuantidadeCompradaToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :quantidade_comprada, :integer, default: 0
  end
end
