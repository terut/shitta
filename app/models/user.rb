class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :username, :password, :password_confirmation, :name, :email, :bio

  has_many :notes

  validates :username, presence: true
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  def image_url
    'https://exstamp01.s3-ap-northeast-1.amazonaws.com/uploads/user/image/22/size_120_images.jpg'
  end
end
