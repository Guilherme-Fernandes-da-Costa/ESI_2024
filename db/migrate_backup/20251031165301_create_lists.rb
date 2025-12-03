# db/migrate/xxxx_create_lists.rb
class CreateLists < ActiveRecord::Migration[7.0]
  def change
    create_table :lists do |t|
      t.string :name
      t.references :owner, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
