class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :rate, inclusion: {in: Settings.rates}
end
