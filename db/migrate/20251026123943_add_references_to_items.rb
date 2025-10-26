class AddReferencesToItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :items, :list, null: false, foreign_key: true
    add_reference :items, :added_by, null: false, foreign_key: true
  end
end
