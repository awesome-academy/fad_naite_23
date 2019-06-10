class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  scope :alphabet, ->{order :name}
  scope :newest, ->{order created_at: :desc}
end
