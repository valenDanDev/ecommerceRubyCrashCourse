class OrderItem < ApplicationRecord
    belongs_to :order
    belongs_to :productS
    # OrderItem attributes
    attribute :quantity, :integer
    attribute :subtotal, :decimal
  end
  