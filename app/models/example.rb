class Example < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true, length: { minimum: 15 }
end
