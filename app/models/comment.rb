class Comment < ActiveRecord::Base
  belongs_to :note
  belongs_to :user

  validates :raw_body, presence: true
end
