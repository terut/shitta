class Tagging < ActiveRecord::Base
  belongs_to :note
  belongs_to :tag, counter_cache: true
end
