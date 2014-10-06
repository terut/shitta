class Tag < ActiveRecord::Base
  has_many :taggings

  validates :name, presence: true, length: { maximum: 30 }
end
