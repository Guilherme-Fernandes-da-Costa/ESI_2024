class AddTagToItem < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :tag, :string
  end
end
