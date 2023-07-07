class Cart < ApplicationRecord
    belongs_to :user
    has_many :cart_items
    # Cart attributes
    attribute :total_items, :integer
    attribute :total_price, :decimal
  end
  