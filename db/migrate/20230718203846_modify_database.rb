class ModifyDatabase < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.references :cart, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity
      t.decimal :subtotal
      t.timestamps
    end

    create_table :carts do |t|
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
      t.belongs_to :order, null: false, foreign_key: true
      t.belongs_to :product, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :subtotal

      t.timestamps
    end

    create_table :orders do |t|
      t.string :status
      t.decimal :total_price
      t.datetime :order_date

      t.timestamps
    end

    create_table :shippings do |t|
      t.belongs_to :order, null: false, foreign_key: true
      t.string :fullname
      t.text :address
      t.string :email
      t.integer :phoneNumber
      t.string :bank

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
  end
end
