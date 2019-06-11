class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  scope :alphabet, ->{order(:name)}
end
