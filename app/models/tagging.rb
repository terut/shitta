class Tagging < ActiveRecord::Base
  belongs_to :note
  belongs_to :tag
end
