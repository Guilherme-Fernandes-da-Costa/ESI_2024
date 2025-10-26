class AddListaRefToItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :items, :lists, null: false, foreign_key: true, default: 1
  end
end
