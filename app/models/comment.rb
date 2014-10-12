class Comment < ActiveRecord::Base
  belongs_to :note, counter_cache: true
  belongs_to :user

  validates :raw_body, presence: true
end
