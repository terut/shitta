class Note < ActiveRecord::Base
  belongs_to :user
  attr_accessible :raw_body, :title
end
