class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :notes, through: :taggings

  validates :name, presence: true, length: { maximum: 30 }
end
