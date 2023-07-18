class OrderItem < ApplicationRecord
    belongs_to :order
    belongs_to :product
    # OrderItem attributes
    attribute :quantity, :integer
    attribute :subtotal, :decimal
  end
  