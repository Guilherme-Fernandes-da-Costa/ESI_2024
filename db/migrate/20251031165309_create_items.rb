# db/migrate/xxxx_create_items.rb
class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :list, null: false, foreign_key: true
      t.string :name
      t.integer :quantity, default: 0
      t.timestamps
    end
  end
end
