class Category < ApplicationRecord
    has_many :product_categories,dependent: :destroy
    has_many :product, through: :product_categories
    
    # Category attributes
    attribute :name, :string
  end
  