class Cart < ApplicationRecord
    has_many :cart_items
    # Cart attributes
    attribute :total_items, :integer
    attribute :total_price, :decimal

    def total
      cart_items.to_a.sum { |cart_item| cart_item.subtotal }
  end

  def totalUnits
    cart_items.to_a.sum { |cart_item| cart_item.quantity }
end
  end
  