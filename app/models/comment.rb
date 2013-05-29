class Comment < ActiveRecord::Base
  belongs_to :note
  belongs_to :user
  attr_accessible :raw_body

  validates :raw_body, presence: true
end
