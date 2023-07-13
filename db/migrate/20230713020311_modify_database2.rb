class ModifyDatabase2 < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.references :cart, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity
      t.decimal :subtotal
      t.timestamps
    end

    create_table :carts do |t|
      t.references :user, foreign_key: true
      t.integer :total_items
      t.decimal :total_price
      t.timestamps
    end

    create_table :categories do |t|
      t.string :name
      t.timestamps
    end

    create_table :examples do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.timestamps
    end

    create_table :order_items do |t|
      t.references :order, foreign_key: true
      t.references :productS, foreign_key: true
      t.integer :quantity
      t.decimal :subtotal
      t.timestamps
    end

    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.references :payment_method, foreign_key: true
      t.string :status
      t.decimal :total_price
      t.datetime :order_date
      t.timestamps
    end

    create_table :payment_methods do |t|
      t.string :name, null: false
      t.text :description
      t.boolean :enabled, default: true
      t.timestamps
    end

    create_table :product_categories do |t|
      t.references :product, foreign_key: true
      t.references :category, foreign_key: true
      t.timestamps
    end

    create_table :products do |t|
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
  end
end
