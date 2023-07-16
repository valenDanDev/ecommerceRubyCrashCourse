class CartItem < ApplicationRecord
    belongs_to :cart
    belongs_to :product
    # CartItem attributes
    attribute :quantity, :integer
    attribute :subtotal, :decimal
  end
  