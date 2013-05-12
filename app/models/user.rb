class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :username, :password, :password_confirmation, :name, :email, :bio

  has_many :notes
  has_many :services
  has_many :comments

  validates :username, presence: true, format: { with: /\A[a-z0-9_]+\z/ }, length: { maximum: 20 }, on: :create
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :email, email: true

  def image_url
    'https://exstamp01.s3-ap-northeast-1.amazonaws.com/uploads/user/image/22/size_120_images.jpg'
  end
end
