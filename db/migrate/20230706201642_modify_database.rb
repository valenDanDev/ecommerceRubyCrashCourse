class ModifyDatabase < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.integer :quantity
      t.decimal :subtotal
      t.references :cart, foreign_key: true
      t.references :productst, foreign_key: true

      t.timestamps
    end

    create_table :carts do |t|
      t.integer :total_items
      t.decimal :total_price
      t.integer :user_id, foreign_key: true

      t.timestamps
    end

    create_table :categories do |t|
      t.string :name

      t.timestamps
    end

    create_table :order_items do |t|
      t.integer :quantity
      t.decimal :subtotal
      t.references :order, foreign_key: true
      t.references :product_s, foreign_key: true

      t.timestamps
    end

    create_table :orders do |t|
      t.string :status
      t.decimal :total_price
      t.datetime :order_date
      t.integer :user_id, foreign_key: true
      t.references :payment_method, foreign_key: true

      t.timestamps
    end

    create_table :payment_methods do |t|
      t.string :name
      t.text :description
      t.boolean :enabled, default: true

      t.timestamps
    end

    create_table :product_categories do |t|
      t.references :productst, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end

    create_table :productst do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.decimal :price

      t.timestamps
    end

    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.boolean :admin, default: false

      t.timestamps
    end

    add_foreign_key :carts, :users, column: :user_id
    add_foreign_key :orders, :users, column: :user_id
  end
end
