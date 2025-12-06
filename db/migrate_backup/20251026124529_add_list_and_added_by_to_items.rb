class AddListAndAddedByToItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :items, :list, foreign_key: true
    add_reference :items, :added_by, foreign_key: { to_table: :users }
  end
end
