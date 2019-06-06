class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_accessor :remember_token

  has_many :products, through: :ratings
  has_many :ratings, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :orders, dependent: :destroy

  has_secure_password

  validates :address, presence: true,
    length: {maximum: Settings.address_max_length}
  validates :email, presence: true, length: {maximum: Settings.email_length},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :name, presence: true, length: {maximum: Settings.name_length}
  validates :password, presence: true,
    length: {minimum: Settings.password_min_length}, allow_nil: true
  validates :phone_number, presence: true,
    length: {maximum: Settings.address_max_length}

  before_save ->{email.downcase!}
  scope :name_alphabet, ->{order(:name)}

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false unless digest
    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update_attributes remember_digest: nil
  end

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end
