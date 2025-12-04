class CreateInitialSchema < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name
      t.timestamps
    end
    add_index :users, :email, unique: true

    create_table :lists do |t|
      t.string :name
      t.references :owner, foreign_key: { to_table: :users }
      t.timestamps
    end

    create_table :items do |t|
      t.references :list, null: false, foreign_key: true
      t.string :name
      t.integer :quantity, default: 0
      t.references :added_by, null: false, foreign_key: { to_table: :users }
      t.string :tag
      t.boolean :comprado, default: false
      t.decimal :preco, precision: 10, scale: 2, default: 0.0
      t.timestamps
    end

    create_table :tags do |t|
      t.string :name
      t.timestamps
    end

    create_table :taggings do |t|
      t.references :item, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
      t.timestamps
    end

    create_table :list_shares do |t|
      t.references :list, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
    add_index :list_shares, [:list_id, :user_id], unique: true
  end
end
