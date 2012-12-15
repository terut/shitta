class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :username, :password, :password_confirmation, :name, :email, :bio

  validates :username, presence: true
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
end
