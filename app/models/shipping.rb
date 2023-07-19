class Shipping < ApplicationRecord
    belongs_to :order
    
    # Shipping attributes
    attribute :fullname, :string
    attribute :address, :text
    attribute :email, :string
    attribute :phoneNumber, :integer
    attribute :bank, :string
    
  end
  