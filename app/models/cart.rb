class Cart < ApplicationRecord
    has_many :cart_items
    # Cart attributes
    attribute :total_items, :integer
    attribute :total_price, :decimal
  end
  