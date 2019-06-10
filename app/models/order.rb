class Order < ApplicationRecord
  enum status: %i(pending accepted cancelled)

  belongs_to :user
  has_many :order_lists, dependent: :destroy
  has_many :products, through: :order_lists

  accepts_nested_attributes_for :order_lists

  scope :newest, ->{order created_at: :desc}
  scope :by_status, ->(status){where(status: status) if status.present?}
end
