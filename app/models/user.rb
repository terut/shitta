class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :name, :email, :bio

  has_many :notes
  has_many :services
  has_many :comments

  # TODO review validates and spec
  validates :username, format: { with: /\A[a-z0-9_]+\z/ }, length: { maximum: 20 }, uniqueness: true, on: :create
  validates :password, confirmation: true, length: { minimum: 4, maximum: 20 }, on: :create
  validates :email, email: true, uniqueness: true
  validates :name, presence: true, length: { maximum: 20 }
  validates :bio, presence: true, length: { maximum: 400 }, on: :update

  def image_url
    'https://exstamp01.s3-ap-northeast-1.amazonaws.com/uploads/user/image/22/size_120_images.jpg'
  end

  # TODO rspec
  def owner?(model)
    return false unless model.respond_to?(:user_id)

    self.id == model.user_id
  end

  def connected?
    !self.services.blank?
  end

  def service_token
    return nil unless connected?

    self.services.first.token
  end
end
