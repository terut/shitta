class Note < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  attr_accessible :raw_body, :title

  validates :title, presence: true, length: { maximum: 250 }
  validates :raw_body, presence: true
end
