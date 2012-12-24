class Service < ActiveRecord::Base
  attr_accessible :provider, :token, :username
end
