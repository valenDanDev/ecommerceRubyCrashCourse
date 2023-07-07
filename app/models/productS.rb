class ProductS < ApplicationRecord
  has_many :product_categories
  has_many :categories, through: :product_categories
  
  # Product attributes
  attribute :name, :string
  attribute :description, :text
  attribute :image_url, :string
  attribute :price, :decimal
end
