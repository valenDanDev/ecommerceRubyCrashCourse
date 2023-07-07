class Category < ApplicationRecord
    has_many :product_categories
    has_many :productSs, through: :product_categories
    
    # Category attributes
    attribute :name, :string
  end
  