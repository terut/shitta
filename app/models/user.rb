class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :bio, :email, :name, :username, :password
end
