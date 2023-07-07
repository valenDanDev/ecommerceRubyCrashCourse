class PaymentMethod < ApplicationRecord
    has_many :orders
    
    # PaymentMethod attributes
    attribute :name, :string
    attribute :description, :text
    attribute :enabled, :boolean, default: true
    
    # Validations
    validates :name, presence: true
  end
  