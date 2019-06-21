class Product < ApplicationRecord
  enum product_type: %i(food drink)

  belongs_to :category
  has_many :order_lists, dependent: :destroy
  has_many :ratings, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.name_length}
  validates :description, presence: true,
    length: {maximum: Settings.description_length}
  validates :price, presence: true, numericality: {only_integer: true}
  validates :discount, allow_nil: true, numericality: true
  validates :product_type, presence: true
  validate  :picture_size

  scope :newest, ->{order created_at: :desc}
  scope :in_cart, ->(ids){where id: ids}
  scope :by_type, ->(type){where(product_type: type) if type.present?}
  scope :category, ->(id){where category_id: id}
  scope :top_rating, ->(_rating){reorder average_rating: :desc}
  scope :price, ->(arrange){reorder price: arrange.parameterize.to_sym}

  mount_uploader :picture, PictureUploader

  private

  def picture_size
    return unless picture.size > Settings.max_upload_size.megabytes
    errors.add :picture, t("less_than_5mb")
  end
end
