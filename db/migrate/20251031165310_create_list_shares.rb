# db/migrate/xxxx_create_list_shares.rb
class CreateListShares < ActiveRecord::Migration[7.0]
  def change
    create_table :list_shares do |t|
      t.references :list, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
    add_index :list_shares, [:list_id, :user_id], unique: true
  end
end
