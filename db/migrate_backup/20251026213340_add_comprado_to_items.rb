class AddCompradoToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :comprado, :boolean, default: false
  end
end
