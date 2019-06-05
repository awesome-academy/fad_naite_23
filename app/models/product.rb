class Product < ApplicationRecord
  belongs_to :category
  has_many :order_lists, dependent: :destroy
  has_many :ratings, dependent: :destroy
end
