class AddListaRefToItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :items, :lista, null: false, foreign_key: true, default: 1
  end
end
