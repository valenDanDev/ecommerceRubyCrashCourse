class Order < ApplicationRecord
    has_many :order_items
    # Order attributes
    attribute :status, :string
    attribute :total_price, :decimal
    attribute :order_date, :datetime
  end
  