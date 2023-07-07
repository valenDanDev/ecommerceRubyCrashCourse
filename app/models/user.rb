class User < ApplicationRecord
  has_many :orders
  has_one :cart
  # User attributes
  attribute :name, :string
  attribute :email, :string
  attribute :password, :string

  # User roles
  attribute :admin, :boolean, default: false

  # Password recovery
  attr_accessor :password_reset_token, :password_reset_sent_at
end
