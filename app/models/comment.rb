class Comment < ActiveRecord::Base
  belongs_to :note
  belongs_to :user
  attr_accessible :raw_body
end
